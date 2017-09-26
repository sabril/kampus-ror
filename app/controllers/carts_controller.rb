class CartsController < ApplicationController
  before_action :authenticate_user!, except: [:checkout_notification]
  skip_before_action :show_search_bar
  protect_from_forgery except: [:checkout_notification]

  def index
    @cart = current_cart
  end
  
  def checkout
    redirect_to current_cart.checkout_url
  end
  
  def checkout_notification
    if PayPal::SDK::Core::API::IPN.valid?(request.raw_post)
      @cart = Cart.find(params[:id])
      unless @cart.completed?
        @cart.process_payment(params)
      end
      head :ok
    else
      head :not_acceptable
    end
  end
  
  def get_discount
    @cart = current_cart
    if @cart.check_discount(params[:cart][:discount_code])
      redirect_to my_cart_path, notice: "Discount code added"
    else
      redirect_to my_cart_path, alert: "Discount code is invalid"
    end
  end
  
  def remove_discount
    current_cart.remove_discount
    redirect_to my_cart_path, notice: "Discount removed"
  end
end
