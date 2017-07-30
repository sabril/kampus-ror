require "application_system_test_case"

class AdminsTest < ApplicationSystemTestCase
  test "visiting the admin url" do
    visit admin_root_path
  
    assert_selector "div.flash_alert", text: "You need to sign in or sign up before continuing."
  end
  
  test "login as admin" do
    visit admin_root_path
    fill_in "Email", with: "admin@test.com"
    fill_in "Password", with: "12345678"
    click_button "Login"
    assert_selector "h2#page_title", text: "Dashboard"
  end
end
