require 'rails_helper'

feature "Admin Orders" do
  context "As an admin and two orders in the database" do

    let!(:order_1) { OrderDecorator.new(create(:order, status: "ordered")) }
    let!(:order_2) { OrderDecorator.new(create(:order, status: "paid")) }

    before(:each) do
      stub_logged_in_user(create(:platform_admin))
      visit admin_dashboard_path
    end

    it "I can see the total number of orders for each status" do
      expect(page).to have_content(order_1.id)
      expect(page).to have_content(todays_date)
      expect(page).to have_content(order_1.status.capitalize)
    end

    it "I can see orders filtered by status" do
      click_on("Ordered")

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_link(order_1.id, href: order_path(order_1))
      expect(page).to_not have_link(order_2.id, href: order_path(order_2))
    end

    it "I can change the status of orders" do
      within(".order-#{order_2.id}") do
        click_on("Cancel")
      end

      expect(current_path).to eq(admin_dashboard_path)

      within(".order-#{order_2.id}") do
        expect(page).to have_content("Cancelled")
      end

      within(".order-#{order_1.id}") do
        click_on("Mark as Paid")
      end

      expect(current_path).to eq(admin_dashboard_path)

      within(".order-#{order_1.id}") do
        within(".status") do
          expect(page).to have_content("Paid")
        end
      end

      within(".order-#{order_1.id}") do
        click_on("Mark as Completed")
      end

      expect(current_path).to eq(admin_dashboard_path)

      within(".order-#{order_1.id}") do
        within(".status") do
          expect(page).to have_content("Completed")
        end
      end
    end
  end
end
