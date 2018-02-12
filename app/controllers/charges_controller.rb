class ChargesController < ApplicationController
  before_action :set_amount

  def new

  end

  def create
    stripe = StripeServices.new(params)
    stripe.create_charge(@amount)
    redirect_to thanks_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to thanks_path
  end

  def thanks
  end

  private
    def set_amount
      @amount = cart.total_price * 100
    end

end
