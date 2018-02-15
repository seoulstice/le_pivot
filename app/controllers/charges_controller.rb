class ChargesController < ApplicationController

  def new
  end

  def create
    @order = OrderCreator.create_order(current_user, cart)
    if @order.save then proceed else reset end
  end

  def thanks
  end

  private

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

end
