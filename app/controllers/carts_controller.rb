class CartsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :show_search_bar
  def index
    @cart = current_user.current_cart
  end
end
