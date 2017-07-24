class PaymentMailer < ApplicationMailer
  def payment_completed(subscription)
    @user = subscription.user
    @course = subscription.course
    mail to: @user.email, subject: "Your Payment Receipt for: #{@course.title}"
  end
end
