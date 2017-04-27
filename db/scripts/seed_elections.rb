puts "Seeding elections ..."

Election.create!([
  {year: 2017},
  {year: 2013},
  {year: 2009},
  {year: 2005}
])