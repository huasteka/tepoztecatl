class OperationsController < SecuredApplicationController
  include TransferService

  before_action :set_stock, only: [:deposit, :withdraw]
  before_action :set_stock_by_id, only: [:set_minimum_stock]

=begin
  @api {post} /operations/stocks/deposit Deposit into stock
  @apiVersion 1.0.0
  @apiGroup Operations
  @apiName CreateStockDeposit
  @apiHeader {String} Authorization Generated JWT token
  @apiUse StockRequestBody
  @apiUse StockModel
  @apiUse ErrorHandler
=end
  def deposit
    create_operation(:deposit)
    render json: @stock, status: :created
  end

=begin
  @api {post} /operations/stocks/withdraw Withdraw from stock
  @apiVersion 1.0.0
  @apiGroup Operations
  @apiName CreateStockWithdraw
  @apiHeader {String} Authorization Generated JWT token
  @apiUse StockRequestBody
  @apiUse StockModel
  @apiUse ErrorHandler
=end
  def withdraw
    create_operation(:withdraw)
    render json: @stock, status: :created
  end

=begin
  @api {post} /operations/stocks/:stock_id/set_minimum Set item stock minimum
  @apiVersion 1.0.0
  @apiGroup Operations
  @apiName SetStockItemLimit
  @apiHeader {String} Authorization Generated JWT token
  @apiParam {Number} stock_id
  @apiBody {Number} minimum_quantity
  @apiUse ErrorHandler
=end
  def set_minimum_stock
    @stock.minimum_quantity = params.permit(:minimum_quantity)[:minimum_quantity]
    @stock.save!
    head :no_content
  end

=begin
  @api {post} /operations/stocks/transfer Transfer item from stock
  @apiVersion 1.0.0
  @apiGroup Operations
  @apiName CreateStockTransfer
  @apiHeader {String} Authorization Generated JWT token
  @apiBody {Object} transfer
  @apiBody {Number} transfer.from_storage_id
  @apiBody {Number} transfer.to_storage_id
  @apiBody {Number} transfer.item_id
  @apiBody {Number} transfer.quantity
  @apiUse ErrorHandler
=end
  def transfer
    params.require(:transfer).permit(:from_storage_id, :to_storage_id, :item_id, :quantity)
    handle_transfer(params[:transfer])
    head :no_content
  end

=begin
  @api {post} /operations/stocks/history Fetch the history of stock operations
  @apiVersion 1.0.0
  @apiGroup Operations
  @apiName FetchOperationHistory
  @apiHeader {String} Authorization Generated JWT token
  @apiQuery {Number} [storage_id]
  @apiUse QueryPagination
  @apiUse OperationModel
  @apiUse ResponseLinks
  @apiUse ResponsePagination
  @apiUse ErrorHandler
=end
  def history
    pagination = Pagination.new params
    operations = Operation.joins(stock: [:storage, :item])
    operations = operations.where({stocks: {storage_id: params[:storage_id]}}) if params[:storage_id].present?
    operations = operations.paginate(pagination.to_param).order(created_at: :desc)
    render json: operations,
           meta: {pagination: pagination_meta(operations)},
           each_serializer: OperationSerializer,
           status: :ok
  end

  private

  def create_operation(type)
    operation = Operation.create!(operation_type: type, stock: @stock, quantity: params[:operation][:quantity])
    if operation.deposit?
      @stock.quantity += operation.quantity
    else
      @stock.quantity -= operation.quantity
    end
    @stock.save!
  end

=begin
  @apiDefine StockRequestBody
  @apiBody {Object} operation
  @apiBody {Number} operation.storage_id
  @apiBody {Number} operation.item_id
  @apiBody {Number} operation.quantity
=end
  def set_stock
    params.require(:operation).permit(:storage_id, :item_id, :quantity)
    operation = params[:operation]
    @stock = Stock.find_or_create_stock(operation[:storage_id], operation[:item_id])
  end

  def set_stock_by_id
    @stock = Stock.find(params[:stock_id]);
  end

end
