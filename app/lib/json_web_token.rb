class JsonWebToken
  # Secret to encode and decode token
  HMAC_SECRET_KEY = Rails.application.secrets.secret_key_base

  def self.encode(payload, expiry = 24.hours.from_now)
    # Set expiry to 24 hours from creation time
    payload[:exp] = expiry.to_i
    # Sign token with application secret
    JWT.encode(payload, HMAC_SECRET_KEY)
  end

  def self.decode(token)
    # Get payload; first index in decoded Array
    body = JWT.decode(token, HMAC_SECRET_KEY, true)[0]
    HashWithIndifferentAccess.new body
    # Rescue from expiry exception
  rescue JWT::ExpiredSignature, JWT::VerificationError => exception
    # Raise custom error to be handled by custom handler
    raise ExceptionHandler::InvalidToken, exception.message
  end
end