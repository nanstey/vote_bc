class District < ApplicationRecord
  validates :name, uniqueness: true

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
    @district_name
  end

  # searches for the boundary points that make up the boundary polygon (from open north api)
  def self.get_boundary_points(name)
    @point_hash = {}
    district = name.sub! ' ', '-'
    url = "https://represent.opennorth.ca/boundaries/british-columbia-electoral-districts-2015-redistribution/#{district.downcase}/shape"
    response = HTTP.get(url)
    boundary = JSON.parse(response)
    boundary['coordinates'][0][0]
  end
end
