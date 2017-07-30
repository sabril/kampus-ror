require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should check has_course" do
    user = users(:user_one)
    course = courses(:one)
    assert user.has_course?(course)
  end
  
  test "should check has_course_review" do
    user = users(:user_one)
    course = courses(:one)
    assert user.has_course_review?(course)
  end
  
  test "should check from_omniauth" do
    facebook_data = init_omniauth_data
    user = User.from_omniauth(facebook_data)
    assert user.persisted?
    assert_equal user.email, "test-from-facebook@test.com"
  end
  
  test "should check new_with_session" do
    facebook_data = init_omniauth_data
    session = Hash.new
    params = Hash.new
    session["devise.facebook_data"] = facebook_data
    user = User.new_with_session(params, session)
    assert_not user.persisted?
    assert_equal user.email, "test-from-facebook@test.com"
  end
end
