require 'rails_helper'

RSpec.describe 'Measure Units API', type: :request do
  # Initialize test data
  let!(:measure_units) { create_list(:measure_unit, 10) }
  let(:measure_unit_id) { measure_units.first.id }

  describe 'GET /api/v1/measure_units' do
    before { get '/api/v1/measure_units' }

    it 'returns measure_units' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/measure_units/:measure_unit_id' do
    before { get "/api/v1/measure_units/#{measure_unit_id}" }

    context 'when the record exists' do
      it 'returns the measure_unit' do
        expect(json).not_to be_empty
        expect(json['result']['id']).to eq(measure_unit_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exists' do
      let(:measure_unit_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /api/v1/measure_units' do
    let(:valid_attributes) { {name: 'First', acronym: '1ST'} }

    context 'when the request is valid' do
      before { post '/api/v1/measure_units', params: valid_attributes }

      it 'creates a measure_unit' do
        expect(json['result']['name']).to eq('First')
        expect(json['result']['acronym']).to eq('1ST')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/measure_units', params: {name: 'Fail'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /api/v1/measure_units/:measure_unit_id' do
    let(:valid_attributes) { {name: 'Second', acronym: '2ND'} }

    context 'when the record exists' do
      before { put "/api/v1/measure_units/#{measure_unit_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /api/v1/measure_units/:measure_unit_id' do
    before { delete "/api/v1/measure_units/#{measure_unit_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
