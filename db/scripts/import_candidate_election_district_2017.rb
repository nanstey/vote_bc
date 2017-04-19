
def seed_districts(csv)
  District.destroy_all
  puts "Seeding districts"
  header = csv.row(1)
  e = header.index('ED Code') + 1
  d = header.index('Electoral District') + 1
  (2..csv.last_row).each do |i|
    pp District.find_or_create_by(name: csv.cell(i,d), abbr: csv.cell(i,e))
  end
end

def seed_candidates(csv, year)
  Candidate.destroy_all
  CandidateElectionDistrict.destroy_all
  puts "Seeding candidates & candidate_election_districts"
  header = csv.row(1)
  a = header.index('Affiliation') + 1
  c = header.index('Candidate Ballot Name') + 1
  d = header.index('Electoral District') + 1
  pp election = Election.find_by(year: year)

  (2..csv.last_row).each do |i|
    pp party_name = csv.cell(i,a)
    pp party = Party.find_by!(name: party_name)
    pp district = District.find_by(name: csv.cell(i,d))
    pp candidate = Candidate.find_or_create_by(name: csv.cell(i,c), party_id: party.id)
    pp CandidateElectionDistrict.find_or_create_by(candidate_id: candidate.id, election_id: election.id, district_id: district.id)
  end
end

puts "Reading candidates 2017 csv ..."

candidates_2017 = Roo::CSV.new(Rails.root.join('db', 'excel', 'candidates_2017.csv'))

seed_districts(candidates_2017)
seed_candidates(candidates_2017, 2017)

puts "DONE SEEDING"