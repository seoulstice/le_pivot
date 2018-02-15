require 'rails_helper'

feature "Admin Dashboard Access" do

  describe "As an admin, when I log into my account" do
    it "I am redirected to the Admin Dashboard" do
      admin = create(:platform_admin)
      visit login_path
      fill_in "session[email]", with: admin.email
      fill_in "session[password]", with: 'password'

      within(".action") { click_on("Login") }

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("You're logged in as an Administrator.")
    end
  end

  describe "as a logged in user when I visit /admin/dashboard" do
    it "I see a 404 error" do
      stub_logged_in_user

      expect {
        visit admin_dashboard_path
      }.to raise_error(ActionController::RoutingError)
    end
  end

  describe "as a visitor when I visit /admin/dashboard" do
    it "I see a 404 error" do
      expect {
        visit admin_dashboard_path
      }.to raise_error(ActionController::RoutingError)
    end
  end
end
