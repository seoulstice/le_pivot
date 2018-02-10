class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  after_action :save_cart

  def show
    @items = cart.items
  end

  def create
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    flash[:notice] = "You now have #{pluralize(cart.count_of(item.id), item.title)}."
    redirect_back(fallback_location: root_path)
  end

  def update
    item = Item.find(params[:id])
    if params[:condition] == "decrease"
      cart.decrease_quantity(item.id)
      flash_removed(item) if cart.contents[item.id].nil?
    else
      cart.increase_quantity(item.id)
    end
    redirect_to cart_path
  end

  def destroy
    item = Item.find(params[:id])
    cart.delete_item(item.id)
    flash_removed(item)
    redirect_back(fallback_location: root_path)
  end

  private

    def flash_removed(item)
      flash_success "Successfully removed <a href=#{item_path(item)}>#{item.title}</a> from your cart."
    end

    def save_cart
      session[:cart] = cart.contents
    end

end
