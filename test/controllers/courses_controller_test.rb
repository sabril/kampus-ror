require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get courses_url
    assert_response :success
  end

  test "should get show" do
    get course_url(courses(:one))
    assert_response :success
  end

end
