class District < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates_presence_of :name, :slug
  validates :name, uniqueness: true
  has_many :election_districts
  has_many :elections, through: :election_districts
  has_many :candidate_election_districts
  has_many :candidates, through: :candidate_election_districts
  has_one :district_alias
  has_one :district_goedatum
  has_one :old_district, through: :district_alias
  has_one :new_district_alias, class_name: "DistrictAlias", foreign_key: :old_district_id
  has_one :new_district, through: :new_district_alias, source: :district

  # For acurate results, finds exact geolocation of addess to pinpoint specific riding using google maps api
  def self.get_geolocation(address)
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{CGI.escape(address)}&key=#{ENV['GOOGLE_MAPS_API_KEY']}"
    response = HTTP.get(url)
    location = JSON.parse(response)
    lat = location["results"][0]["geometry"]["location"]["lat"]
    lng = location["results"][0]["geometry"]["location"]["lng"]
    Hash["lat", lat, "lng", lng]
  end

  # uses open north api (election info) to find riding based on geolocation found in get_geolocation
  def self.get_district(geolocation)
    url = "https://represent.opennorth.ca/boundaries/?contains=#{geolocation['lat']},#{geolocation['lng']}"
    response = HTTP.get(url)
    district = JSON.parse(response)
    district['objects'].each do |boundary_set|
      if boundary_set['boundary_set_name'] == 'British Columbia electoral district'
        @district_name = boundary_set['name']
        break
      end
    end
    District.find_by name: @district_name
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
      district_info.push({
        district: ed,
        candidates: []
      })
      # pp ed
      while ceds[i] && ceds[i].election_id == ed.election_id do
        # pp ceds[i]
        district_info[index][:candidates].push(ceds[i])
        i+=1
      end
    end
    district_info
  end

  def get_graph_data
    graph_data = []
    self.elections.each do |e|
      ceds = CandidateElectionDistrict.where(district_id: self.id, election_id: e.id).order(votes_total: :desc)
      yearlyData = {}
      yearlyData["year"] = e.year
      otherPercent = 0.0
      ceds.each_with_index do |ced|
        candidate = Candidate.find(ced.candidate_id)
        if candidate.party.abbr == "IND" || candidate.party.abbr == "" || candidate.party.abbr == "OTH"
          if ced.votes_percent
            otherPercent += ced.votes_percent
          end
        else
          yearlyData[candidate.party.abbr] = ced.votes_percent
        end
      end
      if otherPercent == 0.0
        yearlyData["Other"] = nil
      else
        yearlyData["Other"] = otherPercent.round(2)
      end
      graph_data << yearlyData
    end
    graph_data.to_json.html_safe
  end
end
