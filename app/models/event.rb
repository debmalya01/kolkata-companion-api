class Event < ApplicationRecord
  belongs_to :pandal
  validates :title, :starts_at, presence: true
end
