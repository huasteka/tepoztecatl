=begin
  @apiDefine ResponseLinks
  @apiSuccess {Object} links
  @apiSuccess {String} links.self
  @apiSuccess {String} links.first
  @apiSuccess {String} links.prev
  @apiSuccess {String} links.next
  @apiSuccess {String} links.last
=end
class SecuredApplicationController < ApplicationController

  before_action :authorize_request

  attr_reader :current_user

  private

  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user_id]
  end

end
