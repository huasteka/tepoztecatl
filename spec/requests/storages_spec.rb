require 'rails_helper'

RSpec.describe 'Storages API', type: :request do
  # Initialize authorization header
  let(:user_id) { Faker::Number.digit }
  let(:headers) { valid_headers }

  # Initialize test data
  let!(:storages) { create_list(:storage, 10) }
  let(:storage_id) { storages.first.id }

  describe 'GET /api/v1/storages' do
    before { get '/api/v1/storages', params: {}, headers: headers }

    it 'returns storages' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/storages/:storage_id' do
    before { get "/api/v1/storages/#{storage_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the storage' do
        expect(json).not_to be_empty
        expect(json['result']['id']).to eq(storage_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exists' do
      let(:storage_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /api/v1/storages' do
    let(:valid_attributes) { { code: '10101010', name: 'Test' } }

    context 'when the request is valid' do
      before { post '/api/v1/storages', params: valid_attributes, headers: headers }

      it 'creates a storage' do
        expect(json['result']['code']).to eq('10101010')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/storages', params: { name: 'Fail' }, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /api/v1/storages/:storage_id' do
    let(:valid_attributes) { { code: '12121212' } }

    context 'when the record exists' do
      before { put "/api/v1/storages/#{storage_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /api/v1/storages/:storage_id' do
    before { delete "/api/v1/storages/#{storage_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
