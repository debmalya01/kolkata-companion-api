class FavoritesController < ApplicationController
  before_action :set_user
  def index
    render json: @user.favorite_pandals.select(:id, :club_name, :year)
  end
  def create
    fav = @user.favorites.create!(pandal_id: params[:pandal_id])
    render json: { id: fav.pandal_id }, status: :created
  end
  def destroy
    @user.favorites.where(pandal_id: params[:id]).delete_all
    head :no_content
  end

  private
  def set_user
    @user = User.first || User.create!(email: "demo@example.com")
  end
  
end