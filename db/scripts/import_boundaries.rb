# pulls point data from open north api
def get_boundary_points(district)
  url = "https://represent.opennorth.ca/boundaries/british-columbia-electoral-districts-2015-redistribution/#{district.slug}/simple_shape"
  puts "  >> #{district.name}"
  response = HTTP.get(url)
  boundary = JSON.parse(response)
  boundary['coordinates'][0][0].each do |point|
    DistrictPoint.create!(
            district_id: district.id,
            lng: point[0],
            lat: point[1]
          )
  end
end

puts "Seeding boundary points for districts..."

districts = District.all

# iterates through each district
districts.each do |district|
  get_boundary_points(district)
end