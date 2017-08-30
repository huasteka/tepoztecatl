class ValidationErrorSerializer

  def initialize(exception)
    @record = exception.record
    @message = exception.message
  end

  def serialize(field, code, status)
    {
        status: Rack::Utils.status_code(status),
        code: fetch_code(code),
        title: fetch_title(field),
        detail: @message
    }
  end

  private

  def fetch_code(code)
    I18n.t(code, scope: [:fields, underscored_resource_name], default: code.to_s)
  end

  def fetch_title(field)
    I18n.t(field, scope: [:errors, :codes], default: field.to_s)
  end

  def underscored_resource_name
    @record.class.to_s.gsub('::', '').underscore
  end

end
