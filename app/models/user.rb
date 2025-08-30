class User < ApplicationRecord
  has_many :plans, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_pandals, through: :favorites, source: :pandal
  validates :email, presence: true, uniqueness: true
end
