class EventsController < ApplicationController
  def index
    scope = Event.includes(pandal: :venue)
    if params[:day].present?
      day = Date.parse(params[:day])
      scope = scope.where(starts_at: day.beginning_of_day..day.end_of_day)
    end
    
    if params[:area].present?
      scope = scope.joins(pandal: :venue).where(venues: { area: params[:area] })
    end

    render json: scope.order(:starts_at).map { |e| serialize_event(e) }
  end

  private
  def serialize_event(e)
    {
      id: e.id,
      title: e.title,
      starts_at: e.starts_at,
      ends_at: e.ends_at,
      event_type: e.event_type,
      pandal: {
        id: e.pandal.id,
        club_name: e.pandal.club_name,
        area: e.pandal.venue.area
      }
    }
  end
end