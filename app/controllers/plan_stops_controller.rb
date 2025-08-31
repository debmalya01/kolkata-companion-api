class PlanStopsController < ApplicationController
  before_action :set_user
  before_action :set_plan
  def create
    stop = @plan.plan_stops.create!(stop_params)
    render json: { id: stop.id }, status: :created
  end
  def update
    stop = @plan.plan_stops.find(params[:id])
    stop.update!(stop_params)
    render json: { ok: true }
  end
  def destroy
    stop = @plan.plan_stops.find(params[:id])
    stop.destroy!
    head :no_content
  end
  
  private
  def set_user
    @user = User.first || User.create!(email: "demo@example.com") 
  end

  def set_plan
    @plan = @user.plans.find(params[:plan_id])
  end

  def stop_params
    params.require(:plan_stop).permit(:pandal_id, :stop_order, :chosen_mode, :est_travel_min, :est_travel_cost)
  end
end