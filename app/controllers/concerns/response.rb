module Response

  class Pagination
    DEFAULT_CURRENT_PAGE = 1
    DEFAULT_PAGE_SIZE = 10

    attr_reader :current_page, :page_size

    def initialize(params)
      @current_page = params.fetch('current_page', DEFAULT_CURRENT_PAGE)
      @page_size = params.fetch('page_size', DEFAULT_PAGE_SIZE)
    end

    def to_param
      { :page => @current_page, :per_page => @page_size }
    end
  end

  class JsonRepresentation
    attr_accessor :result, :meta, :errors
  end

  class JsonResponseMeta
    attr_accessor :current_page, :page_size, :total_items

    def initialize(current_page, page_size, total_items)
      @current_page = current_page
      @page_size = page_size
      @total_items = total_items
    end
  end

  class JsonResponseError
    attr_accessor :code, :message
  end

  def json_response(result, status = :ok)
    json_response_with_meta(result, nil, status)
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