require 'paypal-sdk-core'
class CartsController < ApplicationController
	protect_from_forgery except: [:checkout_notification]
  before_action :authenticate_user!, except: [:checkout_notification]
  skip_before_action :show_search_bar
  before_action :load_cart, except: [:checkout_notification]
  
  def index
  end

  def checkout
  	redirect_to @cart.checkout_url
  end

  def checkout_notification
    if PayPal::SDK::Core::API::IPN.valid?(request.raw_post)
      @cart = Cart.find(params[:id])
      if @cart && @cart.completed == false
        @cart.process_payment(params)
      end
      head :ok
    else
      head :not_acceptable
    end
  end

  def get_discount
    if @cart.check_discount(params[:cart][:discount_code])
      redirect_to my_cart_path, notice: "Discount Code Added"
    else
      redirect_to my_cart_path, alert: "Invalid Discount Code"
    end
  end

  def remove_discount
    @cart.remove_discount
    redirect_to my_cart_path, notice: "Discount Code Removed"
  end

  protected
  def load_cart
    @cart = current_user.current_cart
  end
end
