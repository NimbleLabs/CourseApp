class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :update]
  before_action :ensure_admin, only: [:create, :edit]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

end
