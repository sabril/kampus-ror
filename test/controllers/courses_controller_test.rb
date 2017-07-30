require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  test "should get index" do
    get courses_url
    assert_response :success
  end

  test "should get show" do
    get course_url(courses(:one))
    assert_response :success
  end

  test "should not be able to access my_courses if not signed in" do
    get my_courses_path
    assert_response :redirect
    assert_equal flash[:alert], "You need to sign in or sign up before continuing."
  end
  
  test "should be able to access my_courses if signed in" do
    sign_in(users(:user_one))
    get my_courses_path
    assert_response :success
    assert_nil flash[:alert]
  end
  
  test "should be redirect_to paypal when trying to subscribe a course" do
    sign_in(users(:user_one))
    get subscribe_course_path(courses(:two))
    assert_redirected_to "https://www.sandbox.paypal.com/cgi-bin/webscr?" + courses(:two).paypal_link(users(:user_one))
  end
  
  test "should be redirect_to course if already subscribed" do
    sign_in(users(:user_one))
    get subscribe_course_path(courses(:one))
    assert_redirected_to course_path(courses(:one))
  end
  
  test "should be able to process payment notification" do
    post payment_notification_path, params: {item_number: subscriptions(:two).id, payment_status: "Completed"}
    assert_response :success
  end
end
