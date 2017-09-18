class CartsController < ApplicationController
	protect_from_forgery except: [:checkout_notification]
  before_action :authenticate_user!, except: [:checkout_notification]
  skip_before_action :show_search_bar
  before_action :load_cart
  def index
    @cart = current_user.current_cart
  end

  def checkout
  	redirect_to current_user.current_cart.checkout_url
  end

  def checkout_notification
    @cart = Cart.find(params[:id])
    if @cart && @cart.completed == false
      @cart.process_payment(params)
    end
  	head :ok
  end

  def load_cart
    
  end
end
