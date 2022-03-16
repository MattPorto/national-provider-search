require 'faraday'

class Base
  API_VERSION = "2.1"

  def connect(params)
    base_url = "https://npiregistry.cms.hhs.gov/api/?version=#{API_VERSION}"
    url = base_url + params
    Faraday.get url
  end

  def parsed_response(response)
    JSON.parse response.body
  end

  def has_errors?(response)
    error_response = response.status != 200

    errors = error_response ? response.body : parsed_response(response)['Errors']
    return unless errors

    messages = error_response ? errors : errors.pluck('description').join('; ')
    raise "Some error(s) occurred. Message(s): #{messages}"
  end
end
