class OrdersPresenter
  attr_reader :orders,
              :total_price

  def initialize(orders)
    @orders = orders
    @total_price = orders.sum(:total_price)
  end

end
