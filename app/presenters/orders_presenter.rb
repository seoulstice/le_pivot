class OrdersPresenter
  include ActionView::Helpers::NumberHelper
  attr_reader :orders,
              :total_price

  def initialize(orders)
    @orders = orders.map { |order| OrderDecorator.new(order) }
    @total_price = number_to_currency(orders.sum(:total_price))
  end

end
