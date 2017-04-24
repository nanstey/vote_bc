puts "seeding district aliases from 2015 ..."

def link_districts(new_name, old_name, year)
  new_district = District.find_by(name: new_name)
  old_district = District.find_by(name: old_name)
  DistrictAlias.create!(district_id: new_district.id, old_district_id: old_district.id, year: year)
end

year = 2015

district_changes = [
  {new_name: 'Kelowna West', old_name: 'Westside-Kelowna'},
  {new_name: 'Alberni-Pacific Rim', old_name: 'Mid Island-Pacific Rim'},
  {new_name: 'Chilliwack-Kent', old_name: 'Chilliwack-Hope'},
  {new_name: 'Courtenay-Comox', old_name: 'Comox Valley'},
  {new_name: 'Esquimalt-Metchosin', old_name: 'Esquimalt-Royal Roads'},
  {new_name: 'Langley East', old_name: 'Fort Langley-Aldergrove'},
  {new_name: 'Langford-Juan de Fuca', old_name: 'Juan de Fuca'},
  {new_name: 'Richmond North Centre', old_name: 'Richmond Centre'},
  {new_name: 'Richmond-Queensborough', old_name: 'Richmond East'},
  {new_name: 'Surrey-Guildford', old_name: 'Surrey-Tynehead'}
]

district_changes.each do |dc|
  link_districts(dc[:new_name], dc[:old_name], year)
end