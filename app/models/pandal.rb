class Pandal < ApplicationRecord
  belongs_to :venue
  has_many :pandal_images, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :plan_stops
  has_many :plans, through: :plan_stops

  scope :for_year, ->(y) { where(year: y) if y.present? }
  scope :category, ->(c) { where(category: c) if category.present? }
  scope :by_area, ->(a) { joins(:venue).where(venues: { area: a }) if a.present?}
end
