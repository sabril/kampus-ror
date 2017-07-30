class ReviewsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  def create
    @review = current_user.reviews.new(review_params)
    @course = Course.friendly.find(params[:course_id])
    @review.course = @course
    @review.save
    redirect_to @course, notice: "Review successfully submitted"
  end
  
  def destroy
    @review.destroy
    redirect_to @review.course, notice: "Review successfully removed"
  end
  
  def review_params
    params.require(:review).permit(:star, :comment, :course_id, :user_id)
  end
end
