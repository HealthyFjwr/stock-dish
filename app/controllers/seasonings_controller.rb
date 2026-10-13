class SeasoningsController < ApplicationController
  before_action :require_login

  def index
    @registered_seasoning_ids = current_user.seasoning_ids
    @categories = Seasoning.categories.keys
    @selected_category = params[:category].presence_in(@categories)
    @seasonings = Seasoning.order(:category, :name)
    @seasonings = @seasonings.where(category: @selected_category) if @selected_category
  end
end
