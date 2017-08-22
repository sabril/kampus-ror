class ReviewsChannel < ApplicationCable::Channel
  def self.broadcast(review)
    broadcast_to review.course, review: ReviewsController.render_with_signed_in_user(review.user, partial: "reviews/review", locals: {review: review, course: review.course})
  end
  
  def subscribed
    stream_for Course.first
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
