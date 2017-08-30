module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches StandardErrors
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  include Response

  included do
    rescue_from ExceptionHandler::AuthenticationError, with: :is_unauthorized
    rescue_from ExceptionHandler::MissingToken, with: :is_unauthorized
    rescue_from ExceptionHandler::InvalidToken, with: :is_unauthorized

    rescue_from ActiveRecord::RecordNotFound, with: :is_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :is_unprocessable_entity
  end

  private

  def is_unauthorized(exception)
    render :json => {:errors => exception.message}, :status => :is_unauthorized
  end

  def is_not_found(exception)
    render :json => {:errors => exception.message}, :status => :not_found
  end

  def is_unprocessable_entity(exception)
    render json: serialize_error(exception, :unprocessable_entity), status: :unprocessable_entity
  end

  def serialize_error(exception, status)
    validation_error_serializer = ValidationErrorSerializer.new(exception)
    errors = exception.record.errors.details.map do |field, details|
      details.map do |error_details|
        validation_error_serializer.serialize(field, error_details[:error], status)
      end
    end
    {errors: errors.flatten}
  end

end