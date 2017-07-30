require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "should get redirect if do not have access to task" do
    get course_task_url(courses(:one), tasks(:one))
    assert_response :redirect
  end
  
  test "should be able to access preview task" do
    get course_task_url(courses(:two), tasks(:two))
    assert_response :success
  end
  
  test "should be able to access task if course has been subscribed" do
    sign_in(users(:user_one))
    get course_task_url(courses(:one), tasks(:one))
    assert_response :success
  end
end
