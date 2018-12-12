class OperationsController < SecuredApplicationController
  include TransferService

  before_action :set_stock, only: [:deposit, :withdraw]
  before_action :set_stock_by_id, only: [:set_minimum_stock]

=begin
  @api {post} /stocks/deposit Deposit into stock
  @apiVersion 1.0.0
  @apiGroup Stock
  @apiName CreateStockDeposit
  @apiHeader {String} Authorization Generated JWT token
=end
  def deposit
    create_operation(:deposit)
    render json: @stock, status: :created
  end

=begin
  @api {post} /stocks/withdraw Withdraw from stock
  @apiVersion 1.0.0
  @apiGroup Stock
  @apiName CreateStockWithdraw
  @apiHeader {String} Authorization Generated JWT token
=end
  def withdraw
    create_operation(:withdraw)
    render json: @stock, status: :created
  end

=begin
  @api {post} /stocks/:stock_id/set_minimum Set item stock minimum
  @apiVersion 1.0.0
  @apiGroup Stock
  @apiName SetStockItem
  @apiHeader {String} Authorization Generated JWT token
=end
  def set_minimum_stock
    @stock.minimum_quantity = params.permit(:minimum_quantity)[:minimum_quantity]
    @stock.save!
    head :no_content
  end

=begin
  @api {post} /stocks/transfer Transfer item from stock
  @apiVersion 1.0.0
  @apiGroup Stock
  @apiName CreateStockTransfer
  @apiHeader {String} Authorization Generated JWT token
=end
  def transfer
    params.require(:transfer).permit(:from_storage_id, :to_storage_id, :item_id, :quantity)
    handle_transfer(params[:transfer])
    head :no_content
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

  def set_stock
    params.require(:operation).permit(:storage_id, :item_id, :quantity)
    operation = params[:operation]
    @stock = Stock.find_or_create_stock(operation[:storage_id], operation[:item_id])
  end

  def set_stock_by_id
    @stock = Stock.find(params[:stock_id]);
  end

end
