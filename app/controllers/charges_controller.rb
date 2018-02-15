class ChargesController < ApplicationController

  def new
  end

  def create
    stripe = StripeServices.new(params)
    stripe.create_charge()
    order = OrderCreator.create_order(current_user, cart)
    if order.valid?
      flash_success "Order was successfully placed."
      redirect_to thanks_path
    else
      flash_errors(order)
      redirect_to cart_path
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def thanks
    cart.destroy
  end

end
