class Party < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :abbr, presence: true, uniqueness: true
  has_many :candidates
end
