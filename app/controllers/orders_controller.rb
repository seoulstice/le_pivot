class OrdersController < ApplicationController
  before_action :require_current_user

  def index
    # @user = current_user
    # @user.orders.preload(:items)
    @orders = current_user.orders
    binding.pry
  end

  def show
    if current_admin?
      @order = Order.find(params[:id])
    else
      @order = current_user.orders.find(params[:id])
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order.save
    redirect_back(fallback_location: root_path)
  end


  def create
    order = OrderCreator.create_order(current_user, @cart)
    if order.valid?
      @cart.destroy
      flash[:success] = "Order was successfully placed."
      redirect_to orders_path
    else
      redirect_to cart_path
    end
  end

  private

  def require_current_user
    redirect_to login_path unless current_user
  end

  def order_params
    params.permit(:status, :user_id)
  end

end
