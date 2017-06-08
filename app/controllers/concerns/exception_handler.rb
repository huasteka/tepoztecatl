module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches StandardErrors
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  include Response

  included do
    rescue_from ExceptionHandler::AuthenticationError, with: :is_unauthorized
    rescue_from ExceptionHandler::MissingToken, with: :is_unprocessable_entity
    rescue_from ExceptionHandler::InvalidToken, with: :is_unprocessable_entity

    rescue_from ActiveRecord::RecordNotFound, with: :is_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :is_unprocessable_entity
  end

  private

  def is_unauthorized(exception)
    send_json_response exception, :unauthorized
  end

  def is_unprocessable_entity(exception)
    send_json_response exception, :unprocessable_entity
  end

  def is_not_found(exception)
    send_json_response exception, :not_found
  end

  def send_json_response(exception, status)
    error = JsonResponseError.new
    error.message = exception.message
    errors = [] << error
    json_response_with_errors(errors, status)
  end
end