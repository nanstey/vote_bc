class Candidate < ApplicationRecord
  belongs_to :party
  has_many :candidate_election_districts
  has_many :districts, through: :candidate_election_districts
  has_many :elections, through: :candidate_election_districts
  has_many :election_leaders
  has_one :candidate_alias
  has_one :old_candidate, through: :candidate_alias
  has_one :new_candidate_alias, class_name: "CandidateAlias", foreign_key: :old_candidate_id
  has_one :new_candidate, through: :new_candidate_alias, source: :candidate

  def get_candidate_history
    all_candidates = []
    all_candidates.push(self)
    this = that = self
    while this = this.new_candidate
      all_candidates.unshift(this)
    end
    while that = that.old_candidate
      all_candidates.push(that)
    end
    all_candidates
  end

end
