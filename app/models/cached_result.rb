class CachedResult < ApplicationRecord
  validates :npi, presence: true, uniqueness: { case_sensitive: false }
end
