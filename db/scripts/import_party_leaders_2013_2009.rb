puts "Seeding party leaders 2013 ..."

election = Election.find_by(year: 2013)

green = Candidate.find_by(name: 'Jane Sterk')
liberal = Candidate.find_by(name: 'Gordon Campbell')
ndp = Candidate.find_by(name: 'Carole James')

ElectionLeader.create!([
  {candidate_id: green.id, election_id: election.id},
  {candidate_id: liberal.id, election_id: election.id},
  {candidate_id: ndp.id, election_id: election.id}
])

puts "Seeding party leaders 2009 ..."

election = Election.find_by(year: 2009)

green = Candidate.find_by(name: 'Jane Sterk')
liberal = Candidate.find_by(name: 'Christy Clark')
ndp = Candidate.find_by(name: 'Adrian Dix')

ElectionLeader.create!([
  {candidate_id: green.id, election_id: election.id},
  {candidate_id: liberal.id, election_id: election.id},
  {candidate_id: ndp.id, election_id: election.id}
])