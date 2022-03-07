class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  def routing_error
    render :json => {:errors => [{:status => 404, :title => 'Not Found'}]}, :status => :not_found
  end
end
