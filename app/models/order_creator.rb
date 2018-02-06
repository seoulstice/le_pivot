class OrderCreator


  def create_order(user, cart)
    order = Order.create(total_price: cart.total_price, user: user)
    cart.items.each do |item|
      OrderItem.create(item: item, order: order, quantity: item.quantity)
    end
    order
  end

end
