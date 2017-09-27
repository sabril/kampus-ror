class Api::V1::TasksController < Api::ApplicationController
  def index
    @course = Course.find(params[:course_id])
    @tasks = @course.tasks
    json_response(@tasks)
  end
end
