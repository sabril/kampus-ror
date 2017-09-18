class DiscountCode < ApplicationRecord

	def self.discount_types
		%{
			percentage
			fixed
		}
	end

	def discount_total(total)
		if discount_type == "percentage"
			total - (total.to_f/discount_value)
		elsif discount_type == "fixed"
			total - discount_value
		else
			total
		end
	end
end
