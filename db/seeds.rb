# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts "Deleting tables..."

puts "  >> Deleting Candidate join tables ..."
CandidateAlias.delete_all
CandidateElectionDistrict.delete_all

puts "  >> Deleting District join tables ..."
DistrictGeodatum.delete_all
DistrictPoint.delete_all
DistrictAlias.delete_all

puts "  >> Deleting Election join tables ..."
ElectionDistrict.delete_all
ElectionLeader.delete_all
ElectionParty.delete_all

puts "  >> Deleting Core tables ..."
Election.delete_all
Candidate.delete_all
District.delete_all
Party.delete_all

puts "=============== START SEEDING ==============="

require Rails.root.join('db', 'scripts', 'seed_parties')

require Rails.root.join('db', 'scripts', 'seed_elections')

require Rails.root.join('db', 'scripts', 'import_election_results_2020')

require Rails.root.join('db', 'scripts', 'import_election_results_2017')

require Rails.root.join('db', 'scripts', 'import_election_results_2013_2009')

require Rails.root.join('db', 'scripts', 'import_election_results_2005')

require Rails.root.join('db', 'scripts', 'import_election_results_2001')

require Rails.root.join('db', 'scripts', 'import_election_results_1996')

require Rails.root.join('db', 'scripts', 'seed_party_leaders')

require Rails.root.join('db', 'scripts', 'seed_election_stats')

require Rails.root.join('db', 'scripts', 'seed_electoral_redistributions')

require Rails.root.join('db', 'scripts', 'seed_candidate_alias')

require Rails.root.join('db', 'scripts', 'import_district_geodata')

require Rails.root.join('db', 'scripts', 'import_boundaries')

puts "=============== DONE SEEDING ==============="
