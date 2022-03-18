FactoryBot.define do
  factory :provider_cache do
    npi { 10.times.map { rand(10) }.join }
    name { 'Provider Test' }

    trait :with_full_setup do
      after(:create) do |provider_cache|
        create_list :address, 2, provider_cache: provider_cache
        create :taxonomy, provider_cache: provider_cache
      end
    end
  end
end
