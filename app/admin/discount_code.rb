ActiveAdmin.register DiscountCode do
  permit_params :name, :code, :discount_type, :discount_value, :expired_date, :active
end
