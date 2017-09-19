class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  
  def add_item(course_id)
    course = Course.find(course_id)
    cart_items.find_or_create_by(course_id: course.id, sub_total: course.price)
    update_total
  end
  
  def remove_item(cart_item_id)
    item = cart_items.find(cart_item_id)
    item.destroy
    update_total
  end
  
  def update_total
    self.total = cart_items.sum(:sub_total)
    save
  end
  
  def checkout_url
    params = {
      :business => Rails.application.secrets.paypal_email,
      :cmd => "_cart",
      :upload => 1,
      :notify_url => "#{Rails.application.secrets.site_url}/carts/#{self.id}/checkout_notification",
      :return => "#{Rails.application.secrets.site_url}/my_courses"
    }
    cart_items.each_with_index do |item, index|
      i = index + 1
      params["item_name_#{i}"] = item.course.title
      params["item_numner_#{i}"] = item.course_id
      params["amount_#{i}"] = item.sub_total
    end
    "#{Rails.application.secrets.paypal_url}/cgi-bin/webscr?" + params.to_query
  end
  
  def process_payment(params)
    if params["payment_status"] == "Completed"
      cart_items.each_with_index do |item, index|
        i = index + 1
        if item.sub_total.to_f == params["mc_gross_#{i}"].to_f
          Subscription.find_or_create_by(user: user, course_id: item.course_id, payment_status: "Completed", active: true)
        end
      end
      self.completed = true
      save
    end
  end
  
  def check_discount(code)
    discount_code = DiscountCode.find_by(code: code)
    if discount_code && discount_code.active? && discount_code.expired_date > Date.today
      self.discount_code = code
      cart_items.each do |item|
        item.update_attributes(sub_total: discount_code.discount_total(item.sub_total))
      end
      self.total = discount_code.discount_total(total)
      save
    else
      false
    end
  end
  
  def remove_discount
    self.discount_code = nil
    cart_items.each do |item|
      item.update_attributes(sub_total: item.course.price)
    end
    update_total
  end
end
