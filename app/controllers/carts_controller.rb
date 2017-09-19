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
    @cart = Cart.find(params[:id])
    unless @cart.completed?
      @cart.process_payment(params)
    end
    head :ok
  end
end
