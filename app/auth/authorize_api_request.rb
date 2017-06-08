class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    { user_id: user_id }
  end

  private

  attr_reader :headers

  def user_id
    @user_id ||= decoded_auth_token[:user_id] if decoded_auth_token
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers[:authorization].present?
      return headers[:authorization].split(' ').last
    end
    raise(ExceptionHandler::MissingToken, ExceptionMessage.missing_token)
  end
end
