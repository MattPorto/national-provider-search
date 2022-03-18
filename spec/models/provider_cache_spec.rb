require 'rails_helper'

RSpec.describe ProviderCache, type: :model do
  context 'validations' do
    subject { ProviderCache.new(npi: '12345') }

    it { should validate_presence_of :npi }
    it { should validate_uniqueness_of(:npi).case_insensitive }
  end

  context 'associations' do
    it { should have_many(:addresses).class_name('ProvidersCaches::Address') }
    it { should have_many(:taxonomies).class_name('ProvidersCaches::Taxonomy') }
  end
end
