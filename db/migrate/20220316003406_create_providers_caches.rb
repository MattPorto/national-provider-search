class CreateProvidersCaches < ActiveRecord::Migration[6.1]
  def change
    create_table :provider_caches do |t|
      t.string :npi, null: false
      t.string :name
      t.string :status
      t.string :credential
      t.timestamps
    end

    create_table :providers_cache_addresses do |t|
      t.string :country_code
      t.string :country_name
      t.string :address_purpose
      t.string :address_type
      t.string :address
      t.string :city
      t.string :state

      t.timestamps
    end

    create_table :providers_cache_taxonomies do |t|
      t.string :code
      t.string :desc
      t.boolean :primary
      t.string :state
      t.string :license

      t.timestamps
    end

    add_reference :providers_cache_addresses, :provider_cache, references: :provider_caches, index: true
    add_reference :providers_cache_taxonomies, :provider_cache, references: :provider_caches, index: true
  end
end
