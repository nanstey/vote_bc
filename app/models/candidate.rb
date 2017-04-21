class Candidate < ApplicationRecord
  belongs_to :party
  has_many :candidate_election_districts
  has_many :districts, through: :candidate_election_districts
  has_many :elections, through: :candidate_election_districts
  has_many :election_leaders
end
