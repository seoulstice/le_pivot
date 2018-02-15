class ChargesController < ApplicationController

  def new
    @usps_cost = usps_cost
  end

  def create
    @order = OrderCreator.create_order(current_user, cart, params[:shipping])
    if @order.save then proceed else reset end
  end

  def thanks
  end

  private
    attr_reader :usps_cost

    def charge_customer
      StripeServices.new(params[:stripeEmail], params[:stripeToken]).charge
    end

    def proceed
      charge_customer
      cart.destroy
      redirect_to thanks_path
    rescue Stripe::CardError => e
      reset
      flash_error e.message
    end

    def reset
      flash_validation_errors(@order)
      @order.destroy
      redirect_to new_charge_path
    end

    def shipping_params
      params.permit(:container_type, :zip)
    end

    def usps_cost
      @usps = (UspsService.new(shipping_params).get_rate_calculation_api.to_f) * 100
    end
end
