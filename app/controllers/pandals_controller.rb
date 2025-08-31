class PandalsController < ApplicationController
  def index
    scope = Pandal.includes(:venue, :pandal_images)
    scope = scope.for_year(params[:year])
    scope = scope.category(params[:category])
    scope = scope.by_area(params[:area])

    # /v1/pandals?near=22.57,88.36&radius_m=3000
    if params[:near].present?
      lat, lon = params[:near].split(",").map(&:to_f)
      radius = params[:radius_m].presence&.to_i || 3000

      scope = scope.joins(:venue).where(
        "ST_DWithin(
          venues.location, ST_SetSRID(ST_MakePoint(?, ?), 4326)::geography, ?
        )", lon, lat, radius).order(Arel.sql("ST_DistanceSphere(venues.location, ST_SetSRID(ST_MakePoint(#{lon}, #{lat}), 4326)) ASC")
      )
    end

    render json: scope.map { |p| serialize_pandal(p) }
  end

  def show
    p = Pandal.includes(:venue, :pandal_images, :events).find(params[:id])
    render json: serialize_pandal(p, include_events: true)
  end

  def nearby
    p = Pandal.includes(:venue).find(params[:id])
    type = params[:type].presence || 'Restaurant'
    lat = p.venue.location.latitude
    lon = p.venue.location.longitude
    radius = params[:radius_m].presence&.to_i || 1200

    restaurants = Restaurant.joins(:venue).where(
      rtype: %w[Restaurant Cafe StreetFood].include?(type) ? type :
      %w[Restaurant Cafe StreetFood]
    ).where(
      "ST_DWithin(venues.location, ST_SetSRID(ST_MakePoint(?, ?), 4326)::geography, ?)", lon, lat, radius
    ).limit(30)

    render json: restaurants.map { |r| serialize_restaurant(r) }
  end

  private
  def serialize_pandal(p, include_events: false)
    data = {
      id: p.id,
      club_name: p.club_name,
      year: p.year,
      theme_title: p.theme_title,
      category: p.category,
      rating_estimate: p.rating_estimate,
      crowd_level: p.crowd_level,
      venue: {
        name: p.venue.name,
        address: p.venue.address,
        area: p.venue.area,
        lat: p.venue.location&.latitude,
        lon: p.venue.location&.longitude
      },
      images: p.pandal_images.sort_by(&:sort_order).map { |i| { url: i.url, caption: i.caption } }
    }

    if include_events
      data[:events] = p.events.order(:starts_at).map do |e|
        {
          id: e.id,
          title: e.title,
          starts_at: e.starts_at,
          ends_at: e.ends_at,
          event_type: e.event_type,
        }
      end
    end

    data
    
  end

  def serialize_restaurant(r)
    {
      id: r.id,
      name: r.venue.name,
      address: r.venue.address,
      area: r.venue.area,
      rtype: r.rtype,
      price_band: r.price_band,
      cuisine: r.cuisine,
      rating: r.rating,
      lat: r.venue.location&.latitude,
      lon: r.venue.location&.longitude
    }
  end
end