puts "seeding candidate aliases ..."

def link_candidates(name)
  candidates = Candidate.where(:name => name)
  CandidateAlias.create!(candidate_id: candidates[0].id, old_candidate_id: candidates[1].id)
end

duplicate_candidates = [
  "Michael Henshall",
  "Michael Markwick",
  "John van Dongen",
  "Lawrence Chen",
  "Bob Simpson",
]

duplicate_candidates.each do |dp|
  link_candidates(dp)
end