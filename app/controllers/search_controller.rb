require "np_registry/provider_search"

class SearchController < ApplicationController
  before_action :load_cache
  rescue_from RuntimeError do |e|
    flash[:alert] = e.message
    redirect_to root_path
  end

  def index
  end

  private

  def load_cache
    @result = CachedResult.all
    return if search_params[:search_key].nil?

    @search_key = search_params[:search_key]
    check_search_key

    if provider_not_found
      cached_provider = import_provider
      @result = [cached_provider] + @result.to_a
    end

    flash[:notice] = "Provider found!"
  end

  def search_params
    params.permit :search_key
  end

  def check_search_key
    raise "Invalid NPI. Please insert only numbers." if @search_key.match? /[^0-9]/
  end

  def provider_not_found
    @result.none? { |provider| provider.npi.eql? @search_key }
  end

  def import_provider
    ProviderSearch.new(search_key: @search_key).import_provider
  end
end
