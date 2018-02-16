class OrderCreator


  def self.create_order(user, cart, shipping_params)
    total = cart.total_price + shipping_params
    order = Order.create(total_price: cart.total_price, total_price_with_shipping: total, user: user)
    cart.order_items.each do |item|
      OrderItem.create(item_id: item.id, order: order, quantity: item.quantity)
    end
    # order
  end

end
