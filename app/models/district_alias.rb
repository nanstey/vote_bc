class DistrictAlias < ApplicationRecord
  belongs_to :district
  belongs_to :old_district, :class_name => "District"
end
