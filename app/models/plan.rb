class Plan < ApplicationRecord
  belongs_to :user
  has_many :plan_stops, -> { order(:stop_order) }, dependent: :destroy
  has_many :pandals, through: :plan_stops
  validates :title, :visit_date, presence: true
end
