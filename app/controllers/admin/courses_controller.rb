class Admin::CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :ensure_admin

  layout 'admin'

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end



  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html {redirect_to courses_url, notice: 'Course was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

end
