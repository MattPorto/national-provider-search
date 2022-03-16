require "np_registry/provider_search"

class SearchController < ApplicationController
  before_action :load_cache

  def index
  end

  private

  def load_cache
    @result = CachedResult.all
    return if search_params[:search_key].nil?

    raise "Invalid NPI. Please insert only numbers." if invalid_search_key?

    search_key = search_params[:search_key]
    return unless @result.none? { |provider| provider.npi.eql? search_key }

    cached_provider = ProviderSearch.new(search_key: search_key).import_provider
    @result << cached_provider
  end

  def search_params
    params.permit :search_key
  end

  def invalid_search_key?
    search_params[:search_key].match? /[^0-9]/
  end
end
