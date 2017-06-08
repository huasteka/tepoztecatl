require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user_id) { Faker::Number.digit % 2 }
  # Mock `Authorization` header
  let(:header) { { :authorization => token_generator(user_id) } }
  # Invalid request subject
  subject(:invalid_request_object) { described_class.new({}) }
  # Valid request subject
  subject(:request_object) { described_class.new(header) }

  # This is our entry point into the service class
  describe '#call' do
    # Returns user object when request is valid
    context 'when valid request' do
      it 'returns user object' do
        result = request_object.call
        expect(result[:user_id]).to eq(user_id)
      end
    end

    # Returns error message when invalid request
    context 'when invalid request' do
      context 'when missing token' do
        it 'raises a MissingToken error' do
          expect { invalid_request_object.call }.to raise_error(ExceptionHandler::MissingToken, ExceptionMessage.missing_token)
        end
      end

      context 'when token is expired' do
        let(:header) { { :authorization => expired_token_generator(user_id) } }
        subject(:request_object) { described_class.new(header) }

        it 'raises ExceptionHandler::InvalidToken error' do
          expect { request_object.call }.to raise_error(ExceptionHandler::InvalidToken, /Signature has expired/)
        end
      end
    end
  end
end
