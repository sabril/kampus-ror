class CartItemsController < ApplicationController
  before_action :authenticate_user!
  def destroy
    @cart_item = CartItem.find(params[:id])
    current_cart.remove_item(@cart_item.id)
    redirect_to my_cart_path, notice: "Item removed"
  end
end
