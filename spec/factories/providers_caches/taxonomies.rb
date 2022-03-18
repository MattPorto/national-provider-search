FactoryBot.define do
  factory :taxonomy, class: 'ProvidersCaches::Taxonomy' do
    provider_cache
    code { '1234' }
  end
end
