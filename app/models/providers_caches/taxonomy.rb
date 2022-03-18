module ProvidersCaches
  class Taxonomy < ApplicationRecord
    belongs_to :provider_cache
  end
end
