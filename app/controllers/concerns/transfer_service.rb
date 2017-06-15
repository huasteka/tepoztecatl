module TransferService

  def handle_transfer(params)
    ActiveRecord::Base.transaction do
      perform_operation(:withdraw, params[:from_storage_id], params[:item_id], params[:quantity])
      perform_operation(:deposit, params[:to_storage_id], params[:item_id], params[:quantity])
    end
  end

  private

  def perform_operation(operation_type, storage_id, item_id, quantity)
    stock = Stock.find_or_create_stock storage_id, item_id
    operation = Operation.create!(operation_type: operation_type, stock: stock, quantity: quantity)
    if operation.deposit?
      stock.quantity += operation.quantity
    else
      stock.quantity -= operation.quantity
    end
    stock.save!
  end

end