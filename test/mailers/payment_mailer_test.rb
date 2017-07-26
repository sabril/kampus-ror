require 'test_helper'

class PaymentMailerTest < ActionMailer::TestCase
  test "payment_completed" do
    subscription = subscriptions(:one)
    mail = PaymentMailer.payment_completed(subscription)
    assert_equal "Your Payment Receipt for: #{subscription.course.title}", mail.subject
    assert_equal [subscription.user.email], mail.to
    assert_match "Your Payment for", mail.body.encoded
  end

end
