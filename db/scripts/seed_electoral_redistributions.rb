
def link_districts(new_name, old_name, year)
  new_district = District.find_by(name: new_name)
  old_district = District.find_by(name: old_name)
  DistrictAlias.create!(district_id: new_district.id, old_district_id: old_district.id, year: year)
end

#########################################

puts "seeding district aliases from 2015 ..."

district_changes_2015 = [
  {new_name: 'Kelowna West', old_name: 'Westside-Kelowna'},
  {new_name: 'Mid Island-Pacific Rim', old_name: 'Alberni-Pacific Rim'},
  {new_name: 'Chilliwack-Kent', old_name: 'Chilliwack-Hope'},
  {new_name: 'Courtenay-Comox', old_name: 'Comox Valley'},
  {new_name: 'Esquimalt-Metchosin', old_name: 'Esquimalt-Royal Roads'},
  {new_name: 'Langley East', old_name: 'Fort Langley-Aldergrove'},
  {new_name: 'Langford-Juan de Fuca', old_name: 'Juan de Fuca'},
  {new_name: 'Richmond North Centre', old_name: 'Richmond Centre'},
  {new_name: 'Richmond-Queensborough', old_name: 'Richmond East'},
  {new_name: 'Surrey-Guildford', old_name: 'Surrey-Tynehead'}
]

district_changes_2015.each do |dc|
  link_districts(dc[:new_name], dc[:old_name], 2015)
end

#########################################

puts "seeding district aliases from 2008 ..."

district_changes_2008 = [
  {new_name: 'Kootenay East', old_name: 'East Kootenay'},
  {new_name: 'Chilliwack-Hope', old_name: 'Chilliwack Kent'},
  {new_name: 'Vernon-Monashee', old_name: 'Okanagan-Vernon'},
  {new_name: 'West Vancouver-Sea to Sky', old_name: 'West Vancouver-Garibaldi'},
  {new_name: 'Abbotsford South', old_name: 'Abbotsford-Clayburn'},
  {new_name: 'Abbotsford West', old_name: 'Abbotsford-Mount Lehman'},
  {new_name: 'Alberni-Pacific Rim', old_name: 'Alberni-Qualicum'},
  {new_name: 'Stikine', old_name: 'Bulkley Valley-Stikine'},
  {new_name: 'Burnaby-Deer Lake', old_name: 'Burnaby-Willingdon'},
  {new_name: 'Burnaby-Lougheed', old_name: 'Burquitlam'},
  {new_name: 'Cariboo-Chilcotin', old_name: 'Cariboo South'},
  {new_name: 'Chilliwack', old_name: 'Chilliwack-Sumas'},
  {new_name: 'Cowichan Valley', old_name: 'Cowichan-Ladysmith'},
  {new_name: 'Kamloops-South Thompson', old_name: 'Kamloops'},
  {new_name: 'Juan de Fuca', old_name: 'Malahat-Juan de Fuca'},
  {new_name: 'Westside-Kelowna', old_name: 'Okanagan-Westside'},
  {new_name: 'Penticton', old_name: 'Penticton-Okanagan Valley'},
  {new_name: 'Port Coquitlam', old_name: 'Port Coquitlam-Burke Mountain'},
  {new_name: 'Port Moody-Coquitlam', old_name: 'Port Moody-Westwood'},
  {new_name: 'Prince George-Mackenzie', old_name: 'Prince George North'},
  {new_name: 'Prince George-Valemount', old_name: 'Prince George-Mount Robson'},
  {new_name: 'Nechako Lakes', old_name: 'Prince George-Omineca'},
  {new_name: 'Surrey-Panorama', old_name: 'Surrey-Panorama Ridge'},
  {new_name: 'Vancouver-West End', old_name: 'Vancouver-Burrard'},
  {new_name: 'Victoria-Swan Lake', old_name: 'Victoria-Hillside'},
  {new_name: 'Kootenay West', old_name: 'West Kootenay-Boundary'},
  {new_name: 'Fraser-Nicola', old_name: 'Yale-Lillooet'}
]

district_changes_2008.each do |dc|
  link_districts(dc[:new_name], dc[:old_name], 2008)
end

#########################################

puts "seeding district aliases from 1996 ..."

district_changes_1996 = [
  {new_name: 'Abbotsford-Clayburn', old_name: 'Abbotsford'},
  {new_name: 'Alberni-Qualicum', old_name: 'Alberni'},
  {new_name: 'Chilliwack Kent', old_name: 'Mission-Kent'},
  {new_name: 'Abbotsford-Mount Lehman', old_name: 'Matsqui'},
  {new_name: 'Penticton-Okanagan Valley', old_name: 'Okanagan-Penticton'},
  {new_name: 'Kelowna-Lake Country', old_name: 'Okanagan-East'},
  {new_name: 'Port Moody-Westwood', old_name: 'Port Moody-Burnaby Mountain'},
  {new_name: 'Nanaimo-Parksville', old_name: 'Parksville-Qualicum'},
  {new_name: 'West Kootenay-Boundary', old_name: 'Rossland-Trail'},
  {new_name: 'Kelowna-Mission', old_name: 'Okanagan-West'},
  {new_name: 'Richmond-Steveston', old_name: 'Richmond Steveston'},
  {new_name: 'Vancouver-Fairview', old_name: 'Vancouver-Little Mountain'},
]

district_changes_1996.each do |dc|
  link_districts(dc[:new_name], dc[:old_name], 1996)
end