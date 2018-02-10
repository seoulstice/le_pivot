require 'rails_helper'

RSpec.feature "User can place an order" do
  it "and see the message 'order was successfully placed'" do
    create(:item)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(create(:user))

    visit items_path
    click_on "Add to cart"
    visit cart_path
    click_on "Checkout"

    expect(current_path).to eq('/orders')
    expect(page).to have_content("Order was successfully placed")
  end
end
