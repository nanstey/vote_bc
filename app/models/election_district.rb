class ElectionDistrict < ApplicationRecord
  belongs_to :election
  belongs_to :district
end
