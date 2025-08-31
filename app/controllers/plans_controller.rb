class PlansController < ApplicationController
  before_action :set_user
  before_action :set_plan, only: %i[show update destroy]
  def index
    plans = @user.plans.includes(:plan_stops)
    render json: plans.map { |p| serialize_plan(p) }
  end

  def show
    render json: serialize_plan(@plan)
  end

  def create
    plan = @user.plans.create!(plan_params)
    render json: serialize_plan(plan), status: :created
  end

  def update
    @plan.update!(plan_params)
    render json: serialize_plan(@plan)
  end

  def destroy
    @plan.destroy!
    head :no_content
  end

  private

  def set_user
    # TODO: replace with real auth; for now first user
    @user = User.first || User.create!(email: "demo@example.com")
  end

  def set_plan
    @plan = @user.plans.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:title, :visit_date, :budget_cap)
  end

  def serialize_plan(p)
    {
      id: p.id,
      title: p.title,
      visit_date: p.visit_date,
      budget_cap: p.budget_cap,
      stops: p.plan_stops.order(:stop_order).map do |s|
      {
        id: s.id, stop_order: s.stop_order, chosen_mode: s.chosen_mode,
        est_travel_min: s.est_travel_min, est_travel_cost: s.est_travel_cost,
        pandal: { id: s.pandal.id, club_name: s.pandal.club_name }
      }
      end
    }
  end
end