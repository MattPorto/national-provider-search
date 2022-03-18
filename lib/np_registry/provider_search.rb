require 'np_registry/base'
require 'np_registry/mappers'

class ProviderSearch < Base
  include NpRegistry::Mappers

  def initialize(search_key:)
    @number = search_key
  end

  def import_provider
    response = request_provider

    # threat errors
    has_errors? response

    parsed = parsed_response response

    # return no results
    raise "No Provider found." unless provider_found?(parsed)

    # add to cache if has data
    save_provider parsed
  end

  private

  def request_provider
    query_number = "&number=#{@number}"
    self.connect query_number
  end

  def provider_found?(parsed_response)
    parsed_response['result_count'].nonzero?
  end

  def save_provider(parsed_response)
    results = parsed_response['results']
    providers_list = providers_list_mapper(results)
    ProviderCache.create providers_list
  end
end

