class SeasoningsController < ApplicationController
  before_action :require_login

  def index
    @registered_seasoning_ids = current_user.seasoning_ids
    @selected_category = params[:category].presence_in(Seasoning.categories.keys)
    @seasonings = Seasoning.order(:category, :name)
    @seasonings = @seasonings.where(category: @selected_category) if @selected_category
  end
end
