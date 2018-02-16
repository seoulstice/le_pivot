require 'rails_helper'

feature "Authorization" do
  context "As a logged in user" do

    scenario "A store admin cannot view the platform admin screens" do
      stub_logged_in_user(create(:store_admin))
      [
        admin_orders_path,
        admin_analytics_path,
        admin_stores_path
      ].each do |admin_path|
        expect {
          visit admin_path
        }.to raise_error(ActionController::RoutingError)
      end
    end

    scenario "A user cannot view another user's orders" do
      stub_logged_in_user
      other = create(:user)
      order = create(:order, user: other)
      expect {
        visit order_path(order)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

  end
end
