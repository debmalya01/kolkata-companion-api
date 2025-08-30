class Venue < ApplicationRecord
  has_many :restaurants, dependent: :destroy
  has_many :pandals, dependent: :destroy
  validates :name, :location, presence: true
end
