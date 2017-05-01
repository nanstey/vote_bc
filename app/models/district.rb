class District < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates_presence_of :name, :abbr, :slug
  validates :name, uniqueness: true
  has_many :election_districts
  has_many :elections, through: :election_districts
  has_many :candidate_election_districts
  has_many :candidates, through: :candidate_election_districts
  has_many :district_points
  has_one :district_alias
  has_one :district_goedatum
  has_one :old_district, through: :district_alias
  has_one :new_district_alias, class_name: "DistrictAlias", foreign_key: :old_district_id
  has_one :new_district, through: :new_district_alias, source: :district

  # For acurate results, finds exact geolocation of addess to pinpoint specific riding using google maps api
  def self.get_geolocation(address)
    if address != ''
      url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{CGI.escape(address)}&key=#{ENV['GOOGLE_MAPS_API_KEY']}"
      response = HTTP.get(url)
      location = JSON.parse(response)
      if location["status"] == "ZERO_RESULTS"
        nil
      else
        lat = location["results"][0]["geometry"]["location"]["lat"]
        lng = location["results"][0]["geometry"]["location"]["lng"]
        Hash["lat", lat, "lng", lng]
      end
    end
  end

  # uses open north api (election info) to find riding based on geolocation found in get_geolocation
  def self.get_district(geolocation)
    url = "https://represent.opennorth.ca/boundaries/?contains=#{geolocation['lat']},#{geolocation['lng']}"
    response = HTTP.get(url)
    district = JSON.parse(response)
    district['objects'].each do |boundary_set|
      if boundary_set['boundary_set_name'] == 'British Columbia electoral district'
        return District.find_by name: boundary_set['name']
      end
    end
    nil
  end

  def get_district_history
    all_districts = []
    all_districts.push(self)
    this = that = self
    while this = this.new_district
      all_districts.unshift(this)
    end
    while that = that.old_district
      all_districts.push(that)
    end
    all_districts
  end

  def get_district_history_ids
    district_ids = []
    district_ids.push(self.id)
    this = that = self
    while this = this.new_district
      district_ids.unshift(this.id)
    end
    while that = that.old_district
      district_ids.push(that.id)
    end
    district_ids
  end

  def get_election_district_history
    ids = self.get_district_history_ids
    eds = ElectionDistrict.includes(:election, :district).where(:district_id => ids).order(:id)
    ceds = CandidateElectionDistrict.includes(candidate: [:party]).where(:district_id => ids).order(:election_id, votes_total: :desc)
    district_info = []

    i = 0
    eds.each_with_index do |ed, index|
      if ed.voters_registered
        didnt_vote = ed.voters_registered - ed.total_votes
      else
        didnt_vote = 0
      end

      district_info.push({
        district: ed,
        candidates: [],
        json_line: {
          data: {year: ed.election.year.to_s, },
          colors: []
          },
        json_donut: {
          data:[{label: "Didn't Vote", value: (didnt_vote)}],
          colors: ['#24292e']
        },
        json_area: {}
      })


      j = 0
      while ceds[i] && ceds[i].election_id == ed.election_id do
        district_info[index][:candidates] << ceds[i]
        district_info[index][:json_donut][:data] << {label: ceds[i].candidate.party.abbr, value: ceds[i].votes_total}
        district_info[index][:json_donut][:colors] << ceds[i].candidate.party.color
        if j < 3
          district_info[index][:json_line][:data][ceds[i].candidate.party.abbr] = ceds[i].votes_percent
          district_info[index][:json_line][:colors] << ceds[i].candidate.party.color
        elsif j == 3 && ceds[i].votes_percent
          district_info[index][:json_line][:data][:Other] = ceds[i].votes_percent
          district_info[index][:json_line][:colors] << '#505050'
        elsif j > 3 && ceds[i].votes_percent
          district_info[index][:json_line][:data][:Other] += ceds[i].votes_percent
        end
        i+=1
        j+=1
      end

      if  district_info[index][:json_line][:data][:Other]
        district_info[index][:json_line][:data][:Other] = (district_info[index][:json_line][:data][:Other] * 100).round / 100.0
      end
      district_info[index][:json_line][:data] = district_info[index][:json_line][:data].to_json.html_safe
      district_info[index][:json_line][:colors] = district_info[index][:json_line][:colors]
      district_info[index][:json_donut][:data] = district_info[index][:json_donut][:data].to_json.html_safe
      district_info[index][:json_donut][:colors] = district_info[index][:json_donut][:colors].to_json.html_safe
    end
    district_info
  end

end