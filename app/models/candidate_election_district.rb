class CandidateElectionDistrict < ApplicationRecord
  belongs_to :candidate
  belongs_to :election
  belongs_to :district
end
