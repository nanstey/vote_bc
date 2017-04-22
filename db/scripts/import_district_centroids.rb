puts "Adding boundary centroids for districts..."

districts = District.all

# iterates through each district
districts.each do |district|
  puts "  >> #{district.name}"
  url = "https://represent.opennorth.ca/boundaries/british-columbia-electoral-districts-2015-redistribution/#{district.slug}/centroid"
  response = HTTP.get(url)
  centroid = JSON.parse(response)
  district.update!(centroid_lng: centroid['coordinates'][0], centroid_lat: centroid['coordinates'][1])
end