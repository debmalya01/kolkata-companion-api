class Favorite < ApplicationRecord
  self.primary_key = nil
  belongs_to :user
  belongs_to :pandal
end
