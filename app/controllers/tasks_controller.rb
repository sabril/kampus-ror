class TasksController < ApplicationController
  load_and_authorize_resource
  def show
    course = Course.find(params[:course_id])
    @tasks = course.tasks
    @task = @tasks.find(params[:id])
  end
end
