class ItemsController < SecuredApplicationController

  before_action :set_item, only: [:show, :update, :destroy]

=begin
  @api {get} /items Fetch items list
  @apiVersion 1.0.0
  @apiGroup Item
  @apiName GetItems
  @apiHeader {String} Authorization User generated JWT token
=end
  def index
    pagination = Pagination.new params
    @items = Item.paginate(pagination.to_param).order({code: :desc})
    render json: @items, meta: {pagination: pagination_meta(@items)}, each_serializer: SimpleItemSerializer, status: :ok
  end

=begin
  @api {post} /items Create item
  @apiVersion 1.0.0
  @apiGroup Item
  @apiName CreateItem
  @apiHeader {String} Authorization Generated JWT token
=end
  def create
    @item = Item.create!(item_params)
    render json: @item, status: :created
  end

=begin
  @api {get} /items/:item_id Fetch item
  @apiVersion 1.0.0
  @apiGroup Item
  @apiName GetItem
  @apiHeader {String} Authorization User generated JWT token
=end
  def show
    render json: @item, serializer: ItemWithStocksSerializer, status: :ok
  end

=begin
  @api {put} /items/:item_id Update item
  @apiVersion 1.0.0
  @apiGroup Item
  @apiName UpdateItem
  @apiHeader {String} Authorization User generated JWT token
=end
  def update
    @item.update(item_params)
    head :no_content
  end

=begin
  @api {delete} /items/:item_id Delete item
  @apiVersion 1.0.0
  @apiGroup Item
  @apiName DeleteItem
  @apiHeader {String} Authorization User generated JWT token
=end
  def destroy
    @item.destroy
    head :no_content
  end

  private

  def item_params
    allowed_params = params.permit(:name, :code, :input_quantity, :output_quantity)
    allowed_params[:input_measure_unit] = MeasureUnit.find_by_id(params[:input_measure_unit_id])
    allowed_params[:output_measure_unit] = MeasureUnit.find_by_id(params[:output_measure_unit_id])
    allowed_params
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
