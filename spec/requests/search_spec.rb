require 'rails_helper'

RSpec.describe 'Searches', type: :request do
  describe 'GET /index' do
    it 'no provider in database' do
      get '/search'

      expect(response).to render_template :index
      expect(response.body).to include "There's no records to show."
    end

    context 'searching' do
      context 'invalid results' do
        it 'npi digits are blank' do
          search_key = ''
          error_message = 'Some error(s) occurred. Message(s): No valid search criteria provided'
          params = { search_key: search_key }

          get '/search', params: params

          expect(response).to redirect_to root_path
          follow_redirect!

          expect(response).to render_template :index
          expect(response.body).to include error_message
        end

        it 'no provider found' do
          search_key = '1234567890'
          error_message = 'No Provider found.'
          params = { search_key: search_key }

          get '/search', params: params

          expect(response).to redirect_to root_path
          follow_redirect!

          expect(response).to render_template :index
          expect(response.body).to include error_message
        end

        it 'invalid npi number' do
          search_key = 'abc1234567'
          error_message = 'Invalid NPI. Please insert only numbers.'
          params = { search_key: search_key }

          get '/search', params: params

          expect(response).to redirect_to root_path
          follow_redirect!

          expect(response).to render_template :index
          expect(response.body).to include error_message
        end
      end

      describe 'valid result' do
        it 'collect provider data' do
          search_key = '1528036704'
          params = { search_key: search_key }

          expect { get '/search', params: params }.to change(ProviderCache, :count).by 1

          expect(response).to render_template :index
          expect(ProviderCache.last.npi).to eq search_key
        end

        context 'get provider cache' do
          let!(:provider) { create :provider_cache }

          it 'retaining previous results' do
            get '/search'

            expect(response).to render_template :index
            expect(response.body).to include provider.npi
          end

          it 'use cached as search result' do
            params = { search_key: provider.npi }

            # does not create a new cache record
            expect { get '/search', params: params }.to_not change ProviderCache, :count

            expect(response).to render_template :index
            expect(response.body).to include provider.npi
            expect(response.body).to include 'Provider found!'
          end
        end
      end
    end
  end
end
