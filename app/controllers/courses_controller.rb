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

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html {redirect_to @course, notice: 'Course was successfully created.'}
        format.json {render :show, status: :created, location: @course}
      else
        format.html {render :new}
        format.json {render json: @course.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html {redirect_to @course, notice: 'Course was successfully updated.'}
        format.json {render :show, status: :ok, location: @course}
      else
        format.html {render :edit}
        format.json {render json: @course.errors, status: :unprocessable_entity}
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params.require(:course).permit(:title, :description)
  end

end
