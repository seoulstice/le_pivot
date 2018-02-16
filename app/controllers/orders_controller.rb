class OrdersController < ApplicationController
  before_action :authenticate!

  def index
    @orders = OrderDecorator.map(current_user.orders.preload(:items))
  end

  def show
    @order = OrderDecorator.new(current_user.orders.find(params[:id]))
  end

  def update
    order = viewable.find(params[:id])
    order.assign_attributes(order_params)
    try_save(order, current_dashboard_path, current_dashboard_path, 'order status updated')
    order = Order.find(params[:id])
    flash_errors(order) unless order.update(order_params)
    redirect_back(fallback_location: root_path)
  end

  def create
    usps = UspsService.new(shipping_params)
    order = OrderCreator.create_order(current_user, cart, usps)
    if order.valid?
      cart.destroy
      flash_success "Order was successfully placed."
      redirect_to orders_path
    else
      flash_errors(order)
      redirect_to cart_path
    end
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
