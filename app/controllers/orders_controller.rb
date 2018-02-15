class OrdersController < ApplicationController
  before_action :authenticate!

  def index
    @orders = OrderDecorator.map(viewable.preload(:items))
  end

  def show
    @order = OrderDecorator.new(viewable.find(params[:id]))
  end

  def update
    order = viewable.find(params[:id])
    order.assign_attributes(order_params)
    try_save(order, current_dashboard_path, current_dashboard_path,
      'order status updated')
  end

  private

    def viewable
      if current_user.platform_admin?
        Order.all else current_user.orders
      end
    end

    def order_params
      params.permit(:status)
    end

end
