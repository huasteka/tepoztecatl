class ItemsController < SecuredApplicationController

  before_action :set_item, only: [:show, :update, :destroy]

  def index
    pagination = Pagination.new params
    @items = Item.paginate(pagination.to_param).order({code: :desc})
    render json: @items, meta: {pagination: pagination_meta(@items)}, each_serializer: SimpleItemSerializer, status: :ok
  end

  def create
    @item = Item.create!(item_params)
    render json: @item, status: :created
  end

  def show
    render json: @item, serializer: ItemWithStocksSerializer, status: :ok
  end

  def update
    @item.update(item_params)
    head :no_content
  end

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
