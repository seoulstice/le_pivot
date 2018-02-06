require "rails_helper"

describe "Visitor can navigate to cart page" do
  it "and visitor can login from cart" do
    visit carts_path

    expect(page).to have_link("Login")
    expect(page).to have_link("Create new account")
  end
end
