require "application_system_test_case"

class AdminCoursesTest < ApplicationSystemTestCase
  setup do
    visit admin_root_path
    fill_in "Email", with: "admin@test.com"
    fill_in "Password", with: "12345678"
    click_button "Login"
  end
  
  test "visiting the index" do
    visit admin_courses_path
  
    assert_selector "h2#page_title", text: "Courses"
  end
  
  test "new course form" do
    visit new_admin_course_path
    assert_selector "h2#page_title", text: "New Course"
  end
  
  test "visit course" do
    visit admin_course_path(courses(:one))
    assert_selector "h2#page_title", text: courses(:one).title
  end
  
end
