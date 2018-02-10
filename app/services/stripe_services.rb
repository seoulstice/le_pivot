class StripeServices

  def initialize(params)
    @customer = create_customer(params)
  end

  def create_charge(amount)
    Stripe::Charge.create(
      customer: @customer.id,
      amount: amount.to_i,
      description: 'Your purchase from Artsy!',
      currency: 'usd'
    )
  end

  private

    def create_customer(params)
      Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )
    end

end
