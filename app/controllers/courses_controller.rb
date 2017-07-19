class CoursesController < ApplicationController
  protect_from_forgery except: [:payment_notification]
  before_action :authenticate_user!, only: [:subscribe, :my_courses]
  def index
    @courses = Course.all
  end

  def show
    @course = Course.friendly.find(params[:id])
    @tasks = @course.tasks
  end
  
  def subscribe
    @course = Course.friendly.find(params[:id])
    @subscription = Subscription.find_or_create_by(user: current_user, course_id: @course.id)
    if @subscription.active?
      redirect_to my_courses_path
    else
      values = {
        :business => "syaiful-facilitator@getkeet.com",
        :cmd => "_xclick",
        :upload => 1,
        :amount => @course.price,
        :notify_url => "https://kampus-ror-sabril.c9users.io/payment_notification",
        :item_name => @course.title,
        :item_number => @subscription.id,
        :quantity => 1,
        :return => "https://kampus-ror-sabril.c9users.io/my_courses"
      }
      redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
    end
  end
  
  def my_courses
    @courses = current_user.courses
  end
  
  def payment_notification
    params.permit!
    @subscription = Subscription.find(params[:item_number])
    @subscription.update_attributes({active: true}) if @subscription.active == false && params[:payment_status] == "Completed"
    respond_to do |format|
      format.html {render text: "ok" }
    end
  end
end
