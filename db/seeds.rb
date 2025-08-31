# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.find_or_create_by!(email: "demo@example.com")

# Venues
bagbazar = Venue.create!(
  name: "Bagbazar Sarbojanin",
  address: "Bagbazar, Kolkata",
  area: "North",
  location: "POINT(88.3639 22.6050)"
)
deshapriya = Venue.create!(
  name: "Deshapriya Park",
  address: "Rashbehari Ave, Kolkata",
  area: "South",
  location: "POINT(88.3607 22.5143)"
)

# Pandals
p1 = Pandal.create!(venue: bagbazar, year: 2025, club_name: "Bagbazar Sarbojanin", category: "Traditional")
p2 = Pandal.create!(venue: deshapriya, year: 2025, club_name: "Deshapriya Park", category: "Must-Visit")
PandalImage.create!(pandal: p2, url: "https://example.com/deshapriya.jpg", caption: "Lightscape", sort_order: 1)

# Events
Event.create!(pandal: p1, title: "Sandhi Puja", starts_at: Time.now + 7.days, event_type: "Aarti")
Event.create!(pandal: p2, title: "Evening Aarti", starts_at: Time.now + 7.days + 6.hours, event_type: "Aarti")

# Restaurants near Deshapriya
rven = Venue.create!(
  name: "Kasturi",
  address: "Golpark",
  area: "South",
  location: "POINT(88.3660 22.5175)"
)

Restaurant.create!(venue: rven, rtype: "Restaurant", price_band: "Mid", cuisine: "Bengali", rating: 4.3)