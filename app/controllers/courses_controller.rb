class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @tasks = @course.tasks
  end
  
  def subscribe
    @subscription = Subscription.find_or_create_by(user: current_user, course_id: params[:id])
    redirect_to my_courses_path
  end
  
  def my_courses
    @courses = current_user.courses
  end
end
