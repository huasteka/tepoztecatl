class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :update, :destroy]

  def index
    pagination = Pagination.new params
    @items = Item.paginate pagination.to_param
    metadata = JsonResponseMeta.new(pagination.current_page, pagination.page_size, Item.count)
    json_response_with_meta(@items, metadata)
  end

  def create
    @item = Item.create!(item_params)
    json_response(@item, :created)
  end

  def show
    json_response(@item)
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
