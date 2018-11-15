class UnitsController < ApplicationController
  before_action :set_unit, only: [:show]

  # GET /units
  # GET /units.json
  def index
    @units = Unit.all
  end

  # GET /units/1
  # GET /units/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = Unit.find(params[:id])
    end

end
