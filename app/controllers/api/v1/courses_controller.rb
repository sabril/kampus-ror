class Api::V1::CoursesController < Api::ApplicationController
  def index
    @courses = Course.page(params[:page]).per(10)
    json_response(@courses)
  end
  
  def show
    @course = Course.find(params[:id])
    json_response(@course)
  end
  
  def my_courses
    @courses = current_user.courses
    json_response(@courses)
  end
end