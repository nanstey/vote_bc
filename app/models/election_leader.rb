class ElectionLeader < ApplicationRecord
  belongs_to :election
  belongs_to :leader, :class_name => "Candidate", :foreign_key => "candidate_id"
end
