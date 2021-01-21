# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts "Destroying tables..."

puts "  >> Destroying Candidate join tables ..."
CandidateAlias.destroy_all
CandidateElectionDistrict.destroy_all

puts "  >> Destroying District join tables ..."
DistrictGeodatum.destroy_all
DistrictPoint.destroy_all
DistrictAlias.destroy_all

puts "  >> Destroying Election join tables ..."
ElectionDistrict.destroy_all
ElectionLeader.destroy_all
ElectionParty.destroy_all

puts "  >> Destroying Core tables ..."
Election.destroy_all
Candidate.destroy_all
District.destroy_all
Party.destroy_all

puts "=============== START SEEDING ==============="

require Rails.root.join('db', 'scripts', 'seed_parties')

require Rails.root.join('db', 'scripts', 'seed_elections')

require Rails.root.join('db', 'scripts', 'import_election_results_2020')

# require Rails.root.join('db', 'scripts', 'import_election_results_2017')

# require Rails.root.join('db', 'scripts', 'import_election_results_2013_2009')

# require Rails.root.join('db', 'scripts', 'import_election_results_2005')

# require Rails.root.join('db', 'scripts', 'import_election_results_2001')

# require Rails.root.join('db', 'scripts', 'import_election_results_1996')

# require Rails.root.join('db', 'scripts', 'seed_party_leaders')

# require Rails.root.join('db', 'scripts', 'seed_election_stats')

# require Rails.root.join('db', 'scripts', 'seed_electoral_redistributions')

# require Rails.root.join('db', 'scripts', 'seed_candidate_alias')

# require Rails.root.join('db', 'scripts', 'import_district_geodata')

# require Rails.root.join('db', 'scripts', 'import_boundaries')

puts "=============== DONE SEEDING ==============="
