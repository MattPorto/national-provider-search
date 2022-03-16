require 'rails_helper'
require 'np_registry/provider_search'

RSpec.describe ProviderSearch, type: :lib do
  context '#import_provider' do
    it 'external API returns a server error' do
      search_key = "0000000000"
      error_message = "Some error(s) occurred. Message(s): <h1>Server Error (500)</h1>"

      expect { import_provider search_key }.to raise_error error_message
    end

    it 'external API returns a invalid search criteria error' do
      search_key = ""
      error_message = "Some error(s) occurred. Message(s): No valid search criteria provided"

      expect { import_provider search_key }.to raise_error error_message
    end

    it 'no providers found' do
      search_key = "1234567890"

      expect { import_provider search_key }.to raise_error "No Provider found."
    end

    it 'save provider' do
      search_key = "1528036704" # NPI number example from internet

      expect { import_provider search_key }.to change(CachedResult, :count).by(1)
      expect(CachedResult.last.npi).to eq search_key
    end

    def import_provider(search_key)
      described_class.new(search_key: search_key).import_provider
    end
  end
end