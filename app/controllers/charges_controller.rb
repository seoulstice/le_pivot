class ChargesController < ApplicationController
  before_action :amount_to_be_charged

  def new
  end

  def create
    stripe = StripeServices.new
    stripe.create_customer(params)
    stripe.create_charge(params, @amount)
    redirect_to complete_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  private

    def amount_to_be_charged
      binding.pry
      @amount = 500
    end

end
