class SeasoningsController < ApplicationController
  def index
    @selected_category = params[:category].presence_in(Seasoning.categories.keys)
    @query = params[:q].to_s.strip
    @seasonings = Seasoning.order(:category, :name)
    @seasonings = @seasonings.where(category: @selected_category) if @selected_category
    @seasonings = @seasonings.where("name ILIKE ?", "%#{ActiveRecord::Base.sanitize_sql_like(@query)}%") if @query.present?
  end
end
