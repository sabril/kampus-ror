class Api::V1::TasksController < Api::ApplicationController
  def index
    @course = Course.find(params[:course_id])
    @tasks = @course.tasks
    json_response(@tasks)
  end
  
  def show
    @course = Course.find(params[:course_id])
    @task = @course.tasks.find(params[:id])
    json_response(@task)
  end
end