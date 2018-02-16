require 'rails_helper'

RSpec.feature "Unauthenticated users security" do
  context "As an unauthenticated user" do
    it "I cannot visit dashboard" do
      visit dashboard_path

      expect(current_path).to eq(login_path)
    end

    it "I cannot view an order" do
      order = create(:order)

      visit order_path(order)

      expect(current_path).to eq(login_path)
    end

    it "I should be redirected to login/create account when I try to check out" do
      item = create(:item)

      visit item_path(item)

      click_on "Add to cart"

      click_on "Cart"

      expect(page).to_not have_content("Checkout")
      expect(page).to have_link("Login")
      expect(page).to have_link("create an account")

    end

    it "I cannot view the administrator screens or use administrator functionality" do
      expect {
        visit admin_dashboard_path
      }.to raise_exception(ActionController::RoutingError)
    end
  end
end
