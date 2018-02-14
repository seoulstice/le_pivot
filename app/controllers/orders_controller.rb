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
    flash_errors(order) unless order.update(order_params)
    redirect_back(fallback_location: root_path)
  end

  private

    def viewable
      platform_admin_sees_all! current_user.orders
    end

    def order_params
      params.permit(:status, :user_id)
    end

end
