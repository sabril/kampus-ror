require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get course_task_url(courses(:one), tasks(:one))
    assert_response :redirect
  end

end
