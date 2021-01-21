puts "Adding boundary geodata for districts..."

districts = Election.find_by(:year => Election.current_election_year).districts

# iterates through each district
districts.each do |district|
  puts "  >> #{district.name}"
  if district.name == "Cariboo-Chilcoltin"
    next
  end
  # gets the centoid data from opennorth
  url = "https://represent.opennorth.ca/boundaries/british-columbia-electoral-districts-2015-redistribution/#{district.slug}/centroid"
  response = HTTP.get(url)
  centroid = JSON.parse(response)

  # gets the extent data from opennorth
  url = "https://represent.opennorth.ca/boundaries/british-columbia-electoral-districts-2015-redistribution/#{district.slug}/"
  response = HTTP.get(url)
  extent = JSON.parse(response)

    district_geodata = DistrictGeodatum.create!(
      district_id: district.id,
      centroid_lng: centroid['coordinates'][0],
      centroid_lat: centroid['coordinates'][1],
      extent_south: extent['extent'][0],
      extent_west: extent['extent'][1],
      extent_north: extent['extent'][2],
      extent_east: extent['extent'][3]
    )
end