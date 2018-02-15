class AdminAnalyticsPresenter

  def total_sales
    Order.shop_total_gross
  end

  def average_quantity_purchased
    OrderItem.average_quantity.to_i
  end

  def completed_orders
    Order.count_of_completed_orders
  end

  def sales_by_item_title
    Item.total_sold_by_item
  end

  def orders_per_customer
    User.user_orders
  end

  def items_ordered_per_customer
    User.user_quantity_of_items_ordered
  end
end
