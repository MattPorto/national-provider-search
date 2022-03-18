require 'rails_helper'

RSpec.describe ProvidersCaches::Taxonomy, type: :model do
  context 'associations' do
    it { should belong_to(:provider_cache) }
  end
end