puts "Seeding party leaders 2017 ..."

election = Election.find_by(year: 2017)

green = Candidate.find_by(name: 'Andrew John Weaver')
liberal = Candidate.find_by(name: 'Christy Clark')
ndp = Candidate.find_by(name: 'John Horgan')

ElectionLeader.create!([
  {candidate_id: green.id, election_id: election.id},
  {candidate_id: liberal.id, election_id: election.id},
  {candidate_id: ndp.id, election_id: election.id}
])

#########################################

puts "Seeding party leaders 2013 ..."

election = Election.find_by(year: 2013)

green = Candidate.find_by(name: 'Jane Sterk')
ndp = Candidate.find_by(name: 'Adrian Dix')

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

liberal = Candidate.find_by(name: 'Gordon Campbell')
ndp = Candidate.find_by(name: 'Carole James')

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

green = Candidate.find_by(name: 'Adriane Carr')

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

ndp = Candidate.find_by(name: 'Ujjal Dosanjh')

ElectionLeader.create!([
  {candidate_id: green.id, election_id: election.id},
  {candidate_id: liberal.id, election_id: election.id},
  {candidate_id: ndp.id, election_id: election.id}
])

election.premier_id = liberal.id
election.save!

