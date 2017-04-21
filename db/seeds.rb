# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts "Destroying tables..."

DistrictPoint.destroy_all
CandidateElectionDistrict.destroy_all
ElectionDistrict.destroy_all
ElectionLeader.destroy_all
Election.destroy_all
District.destroy_all
Candidate.destroy_all
Party.destroy_all

puts "=============== START SEEDING ==============="

require Rails.root.join('db', 'scripts', 'seed_parties')

require Rails.root.join('db', 'scripts', 'seed_elections')

require Rails.root.join('db', 'scripts', 'import_candidate_election_district_2017')

require Rails.root.join('db', 'scripts', 'import_boundaries')

require Rails.root.join('db', 'scripts', 'import_election_results_2013_2009')

puts "=============== DONE SEEDING ==============="