class SearchController < ApplicationController
  before_action :load_cache
  def index
  end

  private

  def load_cache
    @result = CachedResult.all
  end

  def search_params
    params.permit :search_key
  end
end
