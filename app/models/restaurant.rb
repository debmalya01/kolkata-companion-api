class Restaurant < ApplicationRecord
  belongs_to :venue
  # rtype: Restaurant/Cafe/StreetFood
end
