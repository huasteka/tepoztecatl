class StoragesController < ApplicationController

  before_action :set_storage, only: [:show, :update, :destroy]

  def index
    pagination = Pagination.new params
    @storages = Storage.where({parent_id: nil}).order({code: :asc}).paginate(pagination.to_param)
    render json: @storages, include: :children, meta: {pagination: pagination_meta(@storages)}, status: :ok
  end

  def create
    @storage = Storage.create!(storage_params)
    render json: @storage, status: :created
  end

  def show
    render json: @storage, status: :ok
  end

  def update
    @storage.update(storage_params)
    head :no_content
  end

  def destroy
    @storage.destroy
    head :no_content
  end

  def create_child
    parent_storage = Storage.find(params[:parent_id])
    child_storage = parent_storage.children.build(storage_params)
    parent_storage.save!
    render json: child_storage, status: :ok
  end

  private

  def storage_params
    params.permit(:code, :name)
  end

  def set_storage
    @storage = Storage.find(params[:id])
  end
end
