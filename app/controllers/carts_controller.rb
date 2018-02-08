class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

<<<<<<< HEAD
  def show
    @items = @cart.cart_items
=======
  def index
    @items = cart.cart_items
>>>>>>> Refactor @cart in application_controller to cart
  end

  def create
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    flash[:notice] = "You now have #{pluralize(cart.count_of(item.id), item.title)}."
    redirect_back(fallback_location: root_path)
  end

  def update
    item_id = params[:id]
    if params[:condition] == "decrease"
      cart.decrease_quantity(item_id)
      if cart.contents[item_id].nil?
        flash[:successfully_removed] = "Successfully removed <a href=#{item_path(item_id)}>#{Item.find(item_id).title}</a> from your cart."
      end
    elsif params[:condition] == "increase"
      cart.increase_quantity(item_id)
    end
    redirect_to cart_path
  end

  def destroy
    item = Item.find(params[:id])
    cart.delete_item(item.id)
    flash[:successfully_removed] = "Successfully removed <a href=#{item_path(item)}>#{item.title}</a> from your cart."
    redirect_back(fallback_location: root_path)
  end

end
