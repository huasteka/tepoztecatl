class StoragesController < ApplicationController

  before_action :set_storage, only: [:show, :update, :destroy]

  def index
    pagination = Pagination.new params
    @storages = Storage.paginate pagination.to_param
    metadata = JsonResponseMeta.new(pagination.current_page, pagination.page_size, Storage.count)
    json_response_with_meta(@storages, metadata)
  end

  def create
    @storage = Storage.create!(storage_params)
    json_response(@storage, :created)
  end

  def show
    json_response(@storage)
  end

  def update
    @storage.update(storage_params)
    head :no_content
  end

  def destroy
    @storage.destroy
    head :no_content
  end

  private

  def storage_params
    params.permit(:code, :name)
  end

  def set_storage
    @storage = Storage.find(params[:id])
  end
end
