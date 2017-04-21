
puts "Reading candidates 2017 csv ..."

csv = Roo::CSV.new(Rails.root.join('db', 'excel', 'candidates_2017.csv'))

header = csv.row(1)
a = header.index('Affiliation') + 1
c = header.index('Candidate Ballot Name') + 1
d = header.index('Electoral District') + 1
e = header.index('ED Code') + 1
year = 2017
election = Election.find_by(year: year)

puts "Seeding districts & candidates for 2017 ..."

(2..csv.last_row).each do |i|
  party_name = csv.cell(i,a)
  party = Party.find_by!(name: party_name)
  district = District.find_or_create_by(name: csv.cell(i,d), abbr: csv.cell(i,e))
  candidate = Candidate.find_or_create_by(name: csv.cell(i,c), party_id: party.id)
  ElectionDistrict.find_or_create_by(election_id: election.id, district_id: district.id)
  CandidateElectionDistrict.find_or_create_by(candidate_id: candidate.id, election_id: election.id, district_id: district.id)
end
