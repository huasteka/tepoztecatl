module ExceptionHandler
  extend ActiveSupport::Concern
  include Response

  included do
    rescue_from ActiveRecord::RecordNotFound do |exception|
      error = JsonResponseError.new
      error.message = exception.message
      errors = [] << error
      json_response_with_errors(errors, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      error = JsonResponseError.new
      error.message = exception.message
      errors = [] << error
      json_response_with_errors(errors, :unprocessable_entity)
    end
  end
end