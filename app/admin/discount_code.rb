ActiveAdmin.register DiscountCode do
  permit_params :name, :code, :discount_percentage, :expired_date, :active
end