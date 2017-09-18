class DiscountCode < ApplicationRecord

	def self.discount_types
		%{
			percentage
			fixed
		}
	end

	def discount_total(total)
		if discount_type == "percentage"
			total - (total.to_f * (discount_value.to_f / 100))
		elsif discount_type == "fixed"
			total - discount_value
		else
			total
		end
	end
end
