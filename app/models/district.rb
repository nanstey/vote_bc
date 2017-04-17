class District < ApplicationRecord
  validates :name, uniqueness: true
end
