puts "Seeding Election stats ..."

ELECTION_2017_HAS_DATA = false

election_2017 = Election.find_by(:year => 2017)

ed_aggs = ElectionDistrict.select("election_id,
  SUM(voters_registered) AS voters_registered,
  SUM(total_votes) AS total_votes,
  SUM(ballots_rejected) AS ballots_rejected,
  SUM(ballots_valid) AS ballots_valid,
  COUNT(*) AS seats").where("election_id > ?", election_2017.id).group(:election_id).order(:election_id)

if ELECTION_2017_HAS_DATA
  elections = Election.order(:id)
else
  elections = Election.where("id > ?", election_2017.id).order(:id)
end

ed_aggs.each_with_index do |ed_a, index|
  elections[index].update!(
    :seats => ed_a.seats,
    :voters_registered => ed_a.voters_registered,
    :total_votes => ed_a.total_votes,
    :ballots_rejected => ed_a.ballots_rejected,
    :ballots_valid => ed_a.ballots_valid,
    :voter_turnout => ((ed_a.total_votes.to_f / ed_a.voters_registered.to_f ) * 100).round(2)
  )
end

puts "Seeding Election Party stats ..."

eds = ElectionDistrict.where("election_id > ?", election_2017.id).order(:election_id, :district_id)
ceds = CandidateElectionDistrict.includes(candidate: [:party]).where("election_id > ?", election_2017.id).order(:election_id, :district_id)

i = 0
j = 0
elections.each do |e|
  party_stats = {}
  while eds[j] && eds[j].election_id == e.id do
    while ceds[i] && ceds[i].district_id == eds[j].district_id do
      party_id = ceds[i].candidate.party.id
      if party_stats[party_id].nil?
        party_stats[party_id] = {candidates_running: 0, seats_won: 0, votes_total: 0}
      end
      party_stats[party_id][:candidates_running] += 1
      party_stats[party_id][:votes_total] += ceds[i].votes_total
      if ceds[i].candidate_id == eds[j].winner_id
        party_stats[party_id][:seats_won] += 1
      end
      i += 1
    end
    j += 1
  end
  puts "  >> #{e.year}"
  party_stats.each do |pid, stats|
    ElectionParty.create!(
      :election_id => e.id,
      :party_id => pid,
      :candidates_running => stats[:candidates_running],
      :seats_won => stats[:seats_won],
      :votes_total => stats[:votes_total],
      :votes_percent => ( (stats[:votes_total].to_f / e.ballots_valid.to_f) * 100).round(2)
    )
  end
end