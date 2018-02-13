class OrdersController < ApplicationController
  before_action :authenticate!

  def index
    @orders = current_user.orders.preload(:items)
  end

  def show
    if current_user.platform_admin?
      @order = Order.find(params[:id])
    else
      @order = current_user.orders.find(params[:id])
    end
  end

  def update
    order = Order.find(params[:id])
    flash_errors(order) unless order.update(order_params)
    redirect_back(fallback_location: root_path)
  end

  private

    def order_params
      params.permit(:status, :user_id)
    end

end
