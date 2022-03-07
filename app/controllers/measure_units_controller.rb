class MeasureUnitsController < SecuredApplicationController

  before_action :set_measure_unit, only: [:show, :update, :destroy]

=begin
  @api {get} /measure_units Fetch measure units list
  @apiVersion 1.0.0
  @apiGroup MeasureUnit
  @apiName GetMeasureUnits
  @apiHeader {String} Authorization User generated JWT token
  @apiUse QueryPagination
  @apiUse MeasureUnitModel
  @apiUse ResponseLinks
  @apiUse ResponsePagination
=end
  def index
    pagination = Pagination.new params
    @measure_units = MeasureUnit.paginate(pagination.to_param).order({acronym: :asc})
    render json: @measure_units, meta: {pagination: pagination_meta(@measure_units)}, status: :ok
  end

=begin
  @api {post} /measure_units Create measure unit
  @apiVersion 1.0.0
  @apiGroup MeasureUnit
  @apiName CreateMeasureUnit
  @apiHeader {String} Authorization Generated JWT token
  @apiUse MeasureUnitRequestBody
  @apiUse MeasureUnitModel
  @apiUse ErrorHandler
=end
  def create
    @measure_unit = MeasureUnit.create!(measure_unit_params)
    render json: @measure_unit, status: :created
  end

=begin
  @api {get} /measure_units/:measure_unit_id Fetch measure unit
  @apiVersion 1.0.0
  @apiGroup MeasureUnit
  @apiName GetMeasureUnit
  @apiHeader {String} Authorization User generated JWT token
  @apiParam {Number} measure_unit_id
  @apiUse MeasureUnitModel
=end
  def show
    render json: @measure_unit, status: :ok
  end

=begin
  @api {put} /measure_units/:measure_unit_id Update measure unit
  @apiVersion 1.0.0
  @apiGroup MeasureUnit
  @apiName UpdateMeasureUnit
  @apiHeader {String} Authorization User generated JWT token
  @apiParam {Number} measure_unit_id
  @apiUse MeasureUnitRequestBody
  @apiUse MeasureUnitModel
  @apiUse ErrorHandler
=end  
  def update
    @measure_unit.update(measure_unit_params)
    head :no_content
  end

=begin
  @api {delete} /measure_units/:measure_unit_id Delete measure unit
  @apiVersion 1.0.0
  @apiGroup MeasureUnit
  @apiName DeleteMeasureUnit
  @apiHeader {String} Authorization User generated JWT token
  @apiParam {Number} measure_unit_id
  @apiUse ErrorHandler
=end
  def destroy
    @measure_unit.destroy
    head :no_content
  end

  private

=begin
  @apiDefine MeasureUnitRequestBody
  @apiBody {String} name
  @apiBody {String} acronym
=end
  def measure_unit_params
    params.permit(:name, :acronym)
  end

  def set_measure_unit
    @measure_unit = MeasureUnit.find(params[:id])
  end

end
