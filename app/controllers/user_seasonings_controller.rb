class UserSeasoningsController < ApplicationController
  before_action :require_login

  def index
    @categories = Seasoning.categories.keys
    @selected_category = params[:category].presence_in(@categories)
    @user_seasonings = current_user.user_seasonings.includes(:seasoning).order("seasonings.category", "seasonings.name")
    @user_seasonings = @user_seasonings.where(seasonings: { category: @selected_category }) if @selected_category
  end

  def create
    seasonings = Seasoning.where(id: params[:seasoning_ids]).where.not(id: current_user.seasoning_ids).to_a

    if seasonings.empty?
      redirect_to seasonings_path, alert: t(".blank")
    else
      current_user.seasonings << seasonings
      redirect_to user_seasonings_path, notice: t(".success", count: seasonings.size)
    end
  end
end
