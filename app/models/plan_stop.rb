class PlanStop < ApplicationRecord
  belongs_to :plan
  belongs_to :pandal
  validates :stop_order, presence: true
end
