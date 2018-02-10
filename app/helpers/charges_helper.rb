module ChargesHelper
  def pretty_amount(amount)
    number_to_currency(amount.to_f / 100)
  end

  def cart_items
    cart.contents
  end

  def order_creator
    order = OrderCreator.create_order(current_user, cart)
    if order.valid?
      flash_success "Order was successfully placed."
      redirect_to thanks_path
    else
      flash_errors(order)
      redirect_to cart_path
    end
  end
end
