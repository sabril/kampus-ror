require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit home_url
  
    assert_selector "a", text: "Sign Up"
  end
  
  test 'users Sign Up' do
    visit new_user_registration_path
    assert_selector "h2", text: "Sign up"
    fill_in "Email", with: "test-user-1@example.com"
    fill_in "Password", with: "12345678"
    fill_in "Password confirmation", with: "12345678"
    click_button "Sign up"
    assert User.where(email: "test-user-1@example.com").first.present?
  end
  
  test "should be failed without facebook credentials" do
    OmniAuth.config.test_mode = true
    visit user_facebook_omniauth_authorize_path
    assert_selector "a", text: "Sign Up"
  end
  
  test "should be failed with invalid facebook credentials" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    visit user_facebook_omniauth_authorize_path
    assert_selector "a", text: "Sign Up"
  end
  
  test "should be success with valid facebook credentials" do
    OmniAuth.config.mock_auth[:facebook] = init_omniauth_data
    visit user_facebook_omniauth_authorize_path
    assert_selector "a", text: "My Courses"
  end
end
