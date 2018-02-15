class OrderCreator

  def self.create_order(user, cart)
    order = Order.create(total_price: cart.total_price, user: user)
    cart.items.each do |item|
      OrderItem.create(item_id: item.id, order: order, quantity: item.quantity)
    end
    order
  end

  def self.create_order(user, cart)
    user.orders.create(
      total_price: cart.total_price,
      order_items_attributes: cart.items.map{ |item| {
        item_id: item.id, quantity: item.quantity
      }}
    )
  end

  def self.create_order(user, cart)
    order_items = cart.order_items
    user.orders.create(
      order_items: order_items,
      total_price: cart.total_price
    )
  end

end
