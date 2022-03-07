
class StoragesController < SecuredApplicationController

  before_action :set_storage, only: [:show, :update, :destroy]

=begin
  @api {get} /storages Fetch storages list
  @apiVersion 1.0.0
  @apiGroup Storage
  @apiName GetStorages
  @apiHeader {String} Authorization User generated JWT token
  @apiUse QueryPagination
  @apiUse StorageModel
  @apiUse ResponseLinks
  @apiUse ResponsePagination
=end
  def index
    pagination = Pagination.new params
    @storages = Storage.where({parent_id: nil}).order({code: :asc}).paginate(pagination.to_param)
    render json: @storages, include: :children, meta: {pagination: pagination_meta(@storages)}, status: :ok
  end

=begin
  @api {post} /storages Create a storage
  @apiVersion 1.0.0
  @apiGroup Storage
  @apiName CreateStorage
  @apiHeader {String} Authorization Generated JWT token
  @apiUse StorageRequestBody
  @apiUse StorageModel
  @apiUse ErrorHandler
=end
  def create
    @storage = Storage.create!(storage_params)
    render json: @storage, status: :created
  end

=begin
  @api {get} /storages/:storage_id Fetch storage
  @apiVersion 1.0.0
  @apiGroup Storage
  @apiName GetStorage
  @apiHeader {String} Authorization User generated JWT token
  @apiParam {Number} storage_id
  @apiUse StorageModel
=end
  def show
    render json: @storage, status: :ok
  end

=begin
  @api {put} /storages/:storage_id Update storage
  @apiVersion 1.0.0
  @apiGroup Storage
  @apiName UpdateStorage
  @apiHeader {String} Authorization User generated JWT token
  @apiParam {Number} storage_id
  @apiUse StorageRequestBody
  @apiUse ErrorHandler
=end
  def update
    @storage.update(storage_params)
    head :no_content
  end

=begin
  @api {delete} /storages/:storage_id Delete storage
  @apiVersion 1.0.0
  @apiGroup Storage
  @apiName DeleteStorage
  @apiHeader {String} Authorization User generated JWT token
  @apiParam {Number} storage_id
  @apiUse ErrorHandler
=end
  def destroy
    @storage.destroy
    head :no_content
  end

=begin
  @api {post} /storages/:storage_id/add Create nested storage
  @apiVersion 1.0.0
  @apiGroup Storage
  @apiName CreateNestedStorage
  @apiHeader {String} Authorization Generated JWT token
  @apiParam {Number} storage_id
  @apiUse StorageRequestBody
  @apiUse StorageModel
  @apiUse ErrorHandler
=end
  def create_child
    parent_storage = Storage.find(params[:parent_id])
    child_storage = parent_storage.children.build(storage_params)
    parent_storage.save!
    render json: child_storage, status: :ok
  end

  private

=begin
  @apiDefine StorageRequestBody
  @apiBody {String} code
  @apiBody {String} name
=end
  def storage_params
    params.permit(:code, :name)
  end

  def set_storage
    @storage = Storage.find(params[:id])
  end

end
