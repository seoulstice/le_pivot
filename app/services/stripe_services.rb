class StripeServices

  def self.create_customer(params)
    Stripe::Customer.create(
    email: params[:email]
    source: params[:stripe_token]
  )
  end

  def self.create_charge(params, amount)
    Stripe::Charge.create(
     customer: params[:customer_id],
     amount: amount,
     description: params[:description],
     currency: 'usd'
   )
  end

end
