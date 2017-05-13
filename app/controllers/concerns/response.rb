module Response

  class JsonRepresentation
    attr_accessor :result, :meta, :errors
  end

  class JsonResponseMeta
    attr_accessor :page_size, :total_results
  end

  class JsonResponseError
    attr_accessor :code, :message
  end

  def json_response(result, status = :ok)
    response = JsonRepresentation.new
    response.result = result
    render json: response, status: status
  end

  def json_response_with_meta(result, meta, status = :ok)
    response = JsonRepresentation.new
    response.result = result
    response.meta = meta
    render json: response, status: status
  end

  def json_response_with_errors(errors, status = :ok)
    response = JsonRepresentation.new
    response.errors = errors
    render json: response, status: status
  end
end