module Response

=begin
  @apiDefine QueryPagination
  @apiQuery {Number} [current_page]
  @apiQuery {Number} [page_size]
=end
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

=begin
  @apiDefine ResponsePagination
  @apiSuccess {Object} meta
  @apiSuccess {Object} meta.pagination
  @apiSuccess {Number} meta.pagination.current_page
  @apiSuccess {Number} meta.pagination.total_pages
  @apiSuccess {Number} meta.pagination.total_items
=end
  def pagination_meta(object)
    {
        current_page: object.current_page,
        total_pages: object.total_pages,
        total_items: object.total_entries
    }
  end
end