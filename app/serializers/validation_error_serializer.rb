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
            title: fetch_title(field, error_details[:error]),
            detail: @message
        }
      end
    end
    {errors: errors.flatten}
  end

  private

  def fetch_title(attribute, message)
    i18n_attribute = I18n.t(attribute, scope: [:activerecord, :attributes, underscored_resource_name])
    i18n_message = I18n.t(message, scope: [:errors, :messages])
    I18n.t(:format, scope: [:errors], attribute: i18n_attribute, message: i18n_message)
  end

  def underscored_resource_name
    @record.class.to_s.gsub('::', '').underscore
  end

end
