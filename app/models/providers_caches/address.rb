module ProvidersCaches
  class Address < ApplicationRecord
    belongs_to :provider_cache
  end
end
