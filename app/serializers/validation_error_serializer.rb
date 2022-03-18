=begin
  @apiDefine ErrorHandler
  @apiError {Object} errors
  @apiError {Number} errors.status
  @apiError {String} errors.title
  @apiError {String} errors.detail
=end
class ValidationErrorSerializer

  def initialize(exception)
    @record = exception.record
    @message = exception.message
  end

  def serialize(status)
    errors = @record.errors.details.map do |field, details|
      details.map do |error_details|
        {
            status: Rack::Utils.status_code(status),
            title: fetch_title(field, error_details[:error], error_details[:count]),
            detail: @message
        }
      end
    end
    {errors: errors.flatten}
  end

  private

  def fetch_title(attribute, message, message_count)
    i18n_attribute = I18n.t attribute, scope: [:activerecord, :attributes, underscored_resource_name]
    i18n_message = I18n.t message, scope: [:errors, :messages], count: message_count
    I18n.t :format, scope: [:errors], attribute: i18n_attribute, message: i18n_message
  end

  def underscored_resource_name
    @record.class.to_s.gsub('::', '').underscore
  end

end
