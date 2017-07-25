require 'test_helper'

class PaymentMailerTest < ActionMailer::TestCase
  test "payment_completed" do
    mail = PaymentMailer.payment_completed
    assert_equal "Payment completed", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
