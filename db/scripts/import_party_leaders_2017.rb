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
