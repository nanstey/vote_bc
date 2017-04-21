class Party < ApplicationRecord
  validates :name, uniqueness: true
  validates :abbr, uniqueness: true
  has_many :candidates
end
