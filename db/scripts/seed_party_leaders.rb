party_gp = Party.find_by(abbr: "GP")
party_lib = Party.find_by(abbr: "LIB")
party_ndp = Party.find_by(abbr: "NDP")
party_pda = Party.find_by(abbr: "PDA")
party_rp = Party.find_by(abbr: "RP")

#########################################

puts "Seeding party leaders 2020 ..."

election = Election.find_by(year: 2020)

green = Candidate.find_by(name: 'Sonia Furstenau', party_id: party_gp.id)
liberal = Candidate.find_by(name: 'Andrew Wilkinson', party_id: party_lib.id)
ndp = Candidate.find_by(name: 'John Horgan', party_id: party_ndp.id)

ElectionLeader.create!([
  {candidate_id: green.id, election_id: election.id},
  {candidate_id: liberal.id, election_id: election.id},
  {candidate_id: ndp.id, election_id: election.id}
])

#########################################

puts "Seeding party leaders 2017 ..."

election = Election.find_by(year: 2017)

green = Candidate.find_by(name: 'Andrew John Weaver', party_id: party_gp.id)
liberal = Candidate.find_by(name: 'Christy Clark', party_id: party_lib.id)
ndp = Candidate.find_by(name: 'John Horgan', party_id: party_ndp.id)

ElectionLeader.create!([
  {candidate_id: green.id, election_id: election.id},
  {candidate_id: liberal.id, election_id: election.id},
  {candidate_id: ndp.id, election_id: election.id}
])

#########################################

puts "Seeding party leaders 2013 ..."

election = Election.find_by(year: 2013)

green = Candidate.find_by(name: 'Jane Sterk', party_id: party_gp.id)
ndp = Candidate.find_by(name: 'Adrian Dix', party_id: party_ndp.id)

ElectionLeader.create!([
  {candidate_id: green.id, election_id: election.id},
  {candidate_id: liberal.id, election_id: election.id},
  {candidate_id: ndp.id, election_id: election.id}
])

election.premier_id = liberal.id
election.save!

#########################################

puts "Seeding party leaders 2009 ..."

election = Election.find_by(year: 2009)

liberal = Candidate.find_by(name: 'Gordon Campbell', party_id: party_lib.id)
ndp = Candidate.find_by(name: 'Carole James', party_id: party_ndp.id)

ElectionLeader.create!([
  {candidate_id: green.id, election_id: election.id},
  {candidate_id: liberal.id, election_id: election.id},
  {candidate_id: ndp.id, election_id: election.id}
])

election.premier_id = liberal.id
election.save!

#########################################

puts "Seeding party leaders 2005 ..."

election = Election.find_by(year: 2005)

green = Candidate.find_by(name: 'Adriane Carr', party_id: party_gp.id)

ElectionLeader.create!([
  {candidate_id: green.id, election_id: election.id},
  {candidate_id: liberal.id, election_id: election.id},
  {candidate_id: ndp.id, election_id: election.id}
])

election.premier_id = liberal.id
election.save!

#########################################

puts "Seeding party leaders 2001 ..."

election = Election.find_by(year: 2001)

ndp = Candidate.find_by(name: 'Ujjal Dosanjh', party_id: party_ndp.id)

ElectionLeader.create!([
  {candidate_id: green.id, election_id: election.id},
  {candidate_id: liberal.id, election_id: election.id},
  {candidate_id: ndp.id, election_id: election.id}
])

election.premier_id = liberal.id
election.save!

#########################################

puts "Seeding party leaders 1996 ..."

election = Election.find_by(year: 1996)

ndp = Candidate.find_by(name: 'Glen Clark', party_id: party_ndp.id)
reform = Candidate.find_by(name: 'Jack Weisgerber', party_id: party_rp.id)
progdem = Candidate.find_by(name: 'Gordon Wilson', party_id: party_pda.id)

ElectionLeader.create!([
  {candidate_id: reform.id, election_id: election.id},
  {candidate_id: progdem.id, election_id: election.id},
  {candidate_id: liberal.id, election_id: election.id},
  {candidate_id: ndp.id, election_id: election.id}
])

election.premier_id = ndp.id
election.save!