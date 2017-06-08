module ControllerSpecHelper
  # Generate tokens from user id
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  # Generate expired tokens from user id
  def expired_token_generator(user_id)
    expiry = Time.now - (24 * 3600)
    JsonWebToken.encode({ user_id: user_id }, expiry)
  end

  # Return valid headers
  def valid_headers
    {
        :authorization => token_generator(user_id),
        :content_type => 'application/json'
    }
  end

  # Return invalid headers
  def invalid_headers
    {
        :authorization => nil,
        :content_type => 'application/json'
    }
  end
end