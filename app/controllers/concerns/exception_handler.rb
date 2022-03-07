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
    render :json => {:errors => [{:status => 401, :title => exception.message}]}, :status => :unauthorized
  end

  def is_not_found(exception)
    render :json => {:errors => [{:status => 404, :title => exception.message}]}, :status => :not_found
  end

  def is_unprocessable_entity(exception)
    render json: ValidationErrorSerializer.new(exception).serialize(:unprocessable_entity), status: :unprocessable_entity
  end

end