require 'rails_helper'

RSpec.describe 'Item API', type: :request do
  # Initialize authorization header
  let(:user_id) { Faker::Number.digit }
  let(:headers) { valid_headers }

  # Initialize test data
  let!(:items) { create_list(:item, 10) }
  let(:item_id) { items.first.id }

  let(:input_measure_unit) { create(:measure_unit) }
  let(:output_measure_unit) { create(:measure_unit) }

  describe 'GET /api/items' do
    before { get '/api/items', params: {}, headers: headers }

    it 'returns items' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/items/:item_id' do
    before { get "/api/items/#{item_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the item' do
        expect(json).not_to be_empty
        expect(json['result']['id']).to eq(item_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exists' do
      let(:item_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /api/items' do
    let(:valid_attributes) { {
        code: 'First',
        input_quantity: 1.0,
        output_quantity: 5.0,
        input_measure_unit_id: input_measure_unit.id,
        output_measure_unit_id: output_measure_unit.id
    } }

    context 'when the request is valid' do
      before { post '/api/items', params: valid_attributes, headers: headers }

      it 'creates a item' do
        expect(json['result']['code']).to eq('First')
        expect(json['result']['input_quantity']).to eq('1.0')
        expect(json['result']['output_quantity']).to eq('5.0')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/items', params: {code: 'Fail', input_quantity: 1.0, output_quantity: 5.0}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /api/items/:item_id' do
    let(:valid_attributes) { {name: 'Updated', code: 'Updated'} }

    context 'when the record exists' do
      before { put "/api/items/#{item_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /api/items/:item_id' do
    before { delete "/api/items/#{item_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
