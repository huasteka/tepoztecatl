class OperationsController < ApplicationController
  include TransferService

  before_action :set_stock, only: [:deposit, :withdraw]

  def deposit
    create_operation(:deposit)
    render json: @stock, status: :created
  end

  def withdraw
    create_operation(:withdraw)
    render json: @stock, status: :created
  end

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

end
