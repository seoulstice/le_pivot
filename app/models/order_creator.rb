class OrderCreator


  def self.create_order(user, cart)
    order = Order.create(total_price: cart.total_price, user: user)
    cart.items.each do |item|
      OrderItem.create(item_id: item.id, order: order, quantity: item.quantity)
    end
    order
  end

end