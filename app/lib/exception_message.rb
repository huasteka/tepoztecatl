class ExceptionMessage
  def self.not_found(record = 'record')
    I18n.t(:not_found, scope: [:exception, :messages], record: record)
  end

  def self.invalid_credentials
    I18n.t(:invalid_credentials, scope: [:exception, :messages])
  end

  def self.invalid_token
    I18n.t(:invalid_token, scope: [:exception, :messages])
  end

  def self.missing_token
    I18n.t(:missing_token, scope: [:exception, :messages])
  end

  def self.unauthorized
    I18n.t(:unauthorized, scope: [:exception, :messages])
  end

  def self.expired_token
    I18n.t(:expired_token, scope: [:exception, :messages])
  end
end
