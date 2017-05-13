class StoragesController < ApplicationController
  include Response
  include ExceptionHandler

  before_action :set_storage, only: [:show, :update, :destroy]

  def index
    @storages = Storage.all
    json_response(@storages)
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
