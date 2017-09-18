class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  
  def add_item(course_id)
  	course = Course.find(course_id)
    cart_items.find_or_create_by(course_id: course_id, sub_total: course.price) 
    update_total(cart_items.sum(:sub_total))
  end

  def update_total(new_total)
  	self.total = new_total
  	save
  end

  def check_discount(code)
  	discount_code = DiscountCode.find_by(code: code)
  	if discount_code && discount_code.active && discount_code.expired_date >= Date.today
  		self.discount_code = code
  		cart_items.each do |item|
  			item.update_attributes(sub_total: discount_code.discount_total(item.sub_total))
  		end
  		self.total = discount_code.discount_total(total)
  		save
  	else
  		return false
  	end
  end

  def remove_discount
  	self.discount_code = nil
  	cart_items.each do |item|
			item.update_attributes(sub_total: item.course.price)
		end
  	update_total(cart_items.sum(:sub_total))
  end

  def checkout_url
  	subscription = Subscription.find_or_create_by(user: user, course_id: id)
    params = {
      :business => Rails.application.secrets.paypal_email,
      :cmd => "_cart",
      :upload => 1,
      :transaction_subject => self.id,
      :notify_url => "#{Rails.application.secrets.site_url}/carts/#{self.id}/checkout_notification",
      :return => "#{Rails.application.secrets.site_url}/my_courses"
    }
    cart_items.each_with_index do |item, index|
    	i = index + 1
    	params["item_name_#{i}"] = item.course.title
    	params["item_number_#{i}"] = item.course.id
    	params["amount_#{i}"] = item.sub_total
    end
    "#{Rails.application.secrets.paypal_url}/cgi-bin/webscr?" + params.to_query
  end

  def process_payment(params)
  	if params["payment_status"] == "Completed"
  		cart_items.each_with_index do |item, index|
  			i = index + 1
  			if params["mc_gross_#{i}"].to_f == item.sub_total.to_f && params["mc_currency"] == "USD"
  				Subscription.find_or_create_by(user: user, course_id: item.course_id, payment_status: "Completed", active: true)
  			end
  		end
  		self.completed = true
  		save
  	end
  end
end
