class CandidateAlias < ApplicationRecord
  belongs_to :candidate
  belongs_to :old_candidate, :class_name => "Candidate"
end
