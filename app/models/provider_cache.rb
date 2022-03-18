class ProviderCache < ApplicationRecord
  validates :npi, presence: true, uniqueness: { case_sensitive: false }

  has_many :addresses, class_name: 'ProvidersCaches::Address'
  has_many :taxonomies, class_name: 'ProvidersCaches::Taxonomy'

  accepts_nested_attributes_for :addresses, :taxonomies

  scope :optimized_collection, -> {   joins(:addresses, :taxonomies)
                                 .includes(:addresses, :taxonomies)
                                 .order(created_at: :desc)
  }

  def main_address
    addresses.first
  end

  def main_taxonomy
    taxonomies.first
  end
end
