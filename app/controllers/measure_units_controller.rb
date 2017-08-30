class MeasureUnitsController < ApplicationController

  before_action :set_measure_unit, only: [:show, :update, :destroy]

  def index
    pagination = Pagination.new params
    @measure_units = MeasureUnit.paginate(pagination.to_param).order({acronym: :asc})
    render json: @measure_units, meta: {pagination: pagination_meta(@measure_units)}, status: :ok
  end

  def create
    @measure_unit = MeasureUnit.create!(measure_unit_params)
    render json: @measure_unit, status: :created
  end

  def show
    render json: @measure_unit, status: :ok
  end

  def update
    @measure_unit.update(measure_unit_params)
    head :no_content
  end

  def destroy
    @measure_unit.destroy
    head :no_content
  end

  private

  def measure_unit_params
    params.permit(:name, :acronym)
  end

  def set_measure_unit
    @measure_unit = MeasureUnit.find(params[:id])
  end
end
