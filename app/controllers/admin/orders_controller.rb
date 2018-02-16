class Admin::OrdersController < ApplicationController

  def index
    @orders = OrderDecorator.map(Order.filter_by_status(params[:status]))
    @by_status = Order.count_by_status
  end

  def update
    order = Order.find(params[:id])
    order.assign_attributes(order_params)
    try_save(order,
      admin_orders_path,
      admin_orders_path,
      "Order ##{order.id} is now #{order.status}."
    )
  end

  private

    def order_params
      params.permit(:status)
    end

end
