module NpRegistry
  module Mappers
    def providers_list_mapper(providers)
      providers.map do |r|
        {
          npi: r['number'],
          name: r['basic']['name'],
          status: r['basic']['status'],
          credential: r['basic']['credential'],
          addresses_attributes: addresses_mapper(r['addresses']),
          taxonomies_attributes: taxonomies_mappers(r['taxonomies'])
        }
      end
    end

    def addresses_mapper(addresses)
      addresses.map do |addr|
        {
          country_code: addr['country_code'],
          country_name: addr['country_name'],
          address_purpose: addr['address_purpose'],
          address_type: addr['address_type'],
          address: addr['address_1'],
          city: addr['city'],
          state: addr['state']
        }
      end
    end

    def taxonomies_mappers(taxonomies)
      taxonomies.map do |tax|
        {
          code: tax['code'],
          desc: tax['desc'],
          primary: tax['primary'],
          state: tax['state'],
          license: tax['license']
        }
      end
    end
  end
end