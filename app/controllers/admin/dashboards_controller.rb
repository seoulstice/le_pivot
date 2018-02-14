class Admin::DashboardsController < ApplicationController
  def show
    @orders = Order.filter_by_status(params[:status])
  end
end
