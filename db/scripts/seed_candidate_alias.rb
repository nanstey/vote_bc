puts "seeding candidate aliases ..."

def link_candidates(name)
  candidates = Candidate.where(:name => name).order(:id)
  (candidates.size - 1).times do |i|
    CandidateAlias.create!(candidate_id: candidates[i].id, old_candidate_id: candidates[i+1].id)
  end
end

duplicate_candidates = [
  ["Andrew John Weaver", "Andrew Weaver"],
  "Bonnie McKinnon",
  "Brian Taylor",
  "Chris Delaney",
  "Clarence Hall",
  ["Donald A. Roberts", "Don Roberts"],
  "Elayne Brenzinger",
  "Erle Martz",
  "George Mann",
  "Gordon Wilson",
  "Hans Mulder",
  "Heather Stilwell",
  "Imtiaz Popat",
  "Jeremy Dalton",
  "Jim Hessels",
  "Joe Pal",
  "John van Dongen",
  "Katrina Chowne",
  "Laery Braaten",
  "Laura McDiarmid",
  "Lawrence Chen",
  "Michael Henshall",
  "Michael Markwick",
  "Mike Hansen",
  "Mike Orr",
  "Norm Siefken",
  "Paddy Roberts",
  "Paul Geddes",
  "R.H. (Bob) Altenhofen",
  "Richard Neufeld",
  "Rick Kasper",
  "Rob Hutchins",
  "Rod Taylor",
  "Sal Vetro",
  "Scott Yee",
  "Simon Gibson",
  "Tom Walker",
  "Tony Goulet",
  "Wilf Hanni"
]

duplicate_candidates.each do |dp|
  link_candidates(dp)
end