class EstimateController < ApplicationController
  def create
    mode = params.dig(:mode) || "Walk"
    # naive: 5km/h walking, 20km/h auto, ₹15/km auto, min ₹40
    from = params.require(:from).permit(:lat, :lon)
    to = params.require(:to).permit(:lat, :lon)
    dist_km = haversine(from[:lat].to_f, from[:lon].to_f, to[:lat].to_f,
    to[:lon].to_f)
    case mode
      when "Walk"
        mins = (dist_km / 5.0 * 60).round
        cost = 0
      when "Auto"
        speed = 20.0
        mins = (dist_km / speed * 60).round
        cost = [(15 * dist_km).round, 40].max
      else
        mins = (dist_km / 15.0 * 60).round
        cost = (12 * dist_km).round
    end
    
    render json: { distance_km: dist_km.round(2), est_travel_min: mins, est_travel_cost: cost, mode: mode }
  end

  private
  def haversine(lat1, lon1, lat2, lon2)
    rad = Math::PI / 180
    rkm = 6371
    dlat = (lat2-lat1) * rad
    dlon = (lon2-lon1) * rad
    lat1r = lat1 * rad
    lat2r = lat2 * rad
    a = Math.sin(dlat/2)**2 + Math.cos(lat1r) * Math.cos(lat2r) * Math.sin(dlon/2)**2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    rkm * c
  end
end