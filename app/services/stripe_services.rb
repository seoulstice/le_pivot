class StripeServices

  def initialize(params)
    @customer = create_customer(params)
  end

  def charge(amount)
    Stripe::Charge.create(
      customer: @customer.id,
      amount: amount.round,
      description: 'Your purchase from Artsy!',
      currency: 'usd'
    )
  end

  private

    def create_customer(email, token)
      Stripe::Customer.create(email: email, source: token)
    end

end
