class SasoningssController < ApplicationController
  def index
    @seasoning = Seasoning.all
  end
end
