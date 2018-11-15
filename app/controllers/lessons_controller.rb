class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show]

  # GET /lessons/1
  # GET /lessons/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

end
