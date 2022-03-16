require 'np_registry/base'

class ProviderSearch < Base
  def initialize(search_key:)
    @number = search_key
  end

  def import_provider
    response = request_provider
    parsed = parsed_response response

    # threat errors
    has_errors? response

    # return no results
    return "No Provider found." unless provider_found?(parsed)

    # add to cache if has data
    save_provider
  end

  private

  def request_provider
    query_number = "&number=#{@number}"
    self.connect query_number
  end

  def provider_found?(parsed_response)
    parsed_response['result_count'].nonzero?
  end

  def save_provider
    CachedResult.create npi: @number # , search_count: 1

    # results = parsed_response['results']
    # providers_list = results.map { |r| { npi: r['number'], search_count: 1 } }
    # CachedResult.create providers_list
  end
end

