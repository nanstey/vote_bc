# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Seeding ..."

Party.destroy_all

puts "Seeding parties ..."

Party.create!([
  {name: 'BC Action Party', abbr: 'BCAP'},
  {name: 'BC Cascadia Party', abbr: 'BCC'},
  {name: 'BC Conservative Party', abbr: 'CP'},
  {name: 'BC First', abbr: 'FP'},
  {name: 'BC Green Party', abbr: 'GP'},
  {name: 'BC Liberal Party', abbr: 'LIB'},
  {name: 'Libertarian', abbr: 'LBN'},
  {name: 'BC NDP', abbr: 'NDP'},
  {name: 'BC Social Credit Party', abbr: 'SC'},
  {name: 'Christian Heritage Party of B.C.', abbr: 'CHP' },
  {name: 'Communist Party of BC', abbr: 'COMM'},
  {name: 'Independent', abbr: 'IND'},
  {name: 'Other', abbr: 'OTH'},
  {name: 'Republican Party', abbr: 'RP'},
  {name: 'The Vancouver Island Party', abbr: 'VIP'},
  {name: 'Your Political Party of BC (YPP)', abbr: 'YPBC'},
  {name: 'No Affiliation', abbr: ''},
  {name: 'The Sex Party', abbr: 'SEX'},
  {name: 'Peoples Front', abbr: 'PF'},
  {name: 'Work Less Party', abbr: 'WLP'},
  {name: 'BC Marijuana Party', abbr: 'BCM'},
  {name: 'BC Excalibur Party', abbr: 'BCEX'},
  {name: 'BC Refed', abbr: 'REFD'},
  {name: 'Western Canada Concept Party', abbr: 'WCC'},
  {name: 'National Alliance Party', abbr: 'NAP'},
  {name: 'The Advocational Party', abbr: 'AID'},
  {name: 'BC Party', abbr: 'BCP'},
  {name: 'Unparty: The Consensus-Building Party', abbr: 'UCBP'},
  {name: 'BC Vision Party', abbr: 'BCV'},
  {name: 'Helping Hand Party', abbr: 'HH'},
  {name: 'Platinum Party', abbr: 'PLAT'}
])

puts "Seeding Election 2017"

Election.find_or_create_by! year: 2017

require Rails.root.join('db', 'scripts', 'import_candidate_election_district_2017')