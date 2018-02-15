class Admin::DashboardsController < ApplicationController
  def show
    @orders = OrderDecorator.map(Order.filter_by_status(params[:status]))
  end
end
