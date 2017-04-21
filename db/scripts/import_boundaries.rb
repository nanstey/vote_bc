# pulls point data from open north api
def get_boundary_points(district)
  district_name = district.name
  district_name = district_name.downcase
  if district_name.include? ' '
    district_name = district_name.gsub! ' ', '-'
  end
  url = "https://represent.opennorth.ca/boundaries/british-columbia-electoral-districts-2015-redistribution/#{district_name}/simple_shape"
  response = HTTP.get(url)
  boundary = JSON.parse(response)
  puts "  >> #{district.name}"
  boundary['coordinates'][0][0].each do |point|
    DistrictPoint.create!(
            district_id: district.id,
            lat: point[0],
            lng: point[1]
          )
  end
end

puts "Seeding boundary points for districts..."

districts = District.all

# iterates through each district
districts.each do |district|
  get_boundary_points(district)
end