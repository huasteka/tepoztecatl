class MeasureUnitsController < ApplicationController
  include Response
  include ExceptionHandler

  before_action :set_measure_unit, only: [:show, :update, :destroy]

  def index
    @measure_units = MeasureUnit.all
    json_response(@measure_units)
  end

  def create
    @measure_unit = MeasureUnit.create!(measure_unit_params)
    json_response(@measure_unit, :created)
  end

  def show
    json_response(@measure_unit)
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
