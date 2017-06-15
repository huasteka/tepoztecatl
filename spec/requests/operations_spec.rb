require 'rails_helper'

RSpec.describe 'Operations API', type: :request do
  # Initialize authorization header
  let(:user_id) { Faker::Number.digit }
  let(:headers) { valid_headers }

  # Initialize test data
  let!(:items) { create_list(:item, 10) }
  let!(:storages) { create_list(:storage, 10) }

  let(:item_id) { items.first.id }
  let(:storage_id) { storages.first.id }
  let(:second_storage_id) { storages[2].id }

  describe 'POST /api/operations/deposit' do
    let(:valid_attributes) { { operation: { storage_id: storage_id, item_id: item_id, quantity: 15 } } }

    context 'when request is valid' do
      before { post '/api/operations/deposit', params: valid_attributes, headers: headers }

      it 'adds a quantity of items into the storage' do
        expect(json['result']['quantity'].to_f).to eq(15.00)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post '/api/operations/deposit', params: {operation: {quantity: 15}}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'POST /api/operations/withdraw' do
    let(:valid_deposit) { { operation: { storage_id: storage_id, item_id: item_id, quantity: 20 } } }
    let(:valid_withdraw) { { operation: { storage_id: storage_id, item_id: item_id, quantity: 15 } } }
    let(:invalid_withdraw) { { operation: { storage_id: storage_id, item_id: item_id, quantity: 30 } } }

    context 'when request is valid' do
      before { post '/api/operations/deposit', params: valid_deposit, headers: headers }
      before { post '/api/operations/withdraw', params: valid_withdraw, headers: headers }

      it 'removes a quantity of items into the storage' do
        expect(json['result']['quantity'].to_f).to eq(5.00)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is valid but quantity is lesser than zero' do
      before { post '/api/operations/withdraw', params: invalid_withdraw, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when request is invalid' do
      before { post '/api/operations/withdraw', params: {operation: {quantity: 20}}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'POST /api/operations/transfer' do
    let(:valid_deposit) { { operation: { storage_id: storage_id, item_id: item_id, quantity: 20 } } }
    let(:valid_transfer) { { transfer: { from_storage_id: storage_id, to_storage_id: second_storage_id, item_id: item_id, quantity: 10 } } }
    let(:invalid_transfer) { { transfer: { from_storage_id: storage_id, to_storage_id: second_storage_id, item_id: item_id, quantity: 50 } } }

    context 'when request is valid' do
      before { post '/api/operations/deposit', params: valid_deposit, headers: headers }
      before { post '/api/operations/transfer', params: valid_transfer, headers: headers }

      it 'transfers an item quantity from one storage to another' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end


  end

end
