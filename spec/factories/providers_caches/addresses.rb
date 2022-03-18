FactoryBot.define do
  factory :address, class: 'ProvidersCaches::Address' do
    provider_cache
    address { '1234 ab street' }
  end
end
