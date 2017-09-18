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
  	self.save
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
  		cart_items.each do |item|
  			Subscription.find_or_create_by(user: user, course_id: item.course_id, payment_status: "Completed", active: true)
  		end
  		self.completed = true
  		save
  	end
  end
end
