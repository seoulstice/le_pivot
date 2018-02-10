require 'rails_helper'

  feature "admin dashboard" do
    feature "admin can visit the admin dashboard" do
      scenario "I will see a heading on the page that says Admin Dashboard" do
        admin_user = create(:platform_admin)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

        visit admin_dashboard_path
        expect(page).to have_content("Admin Dashboard")
      end
    end
  end

  describe "as a logged in user when I visit /admin/dashboard" do
    it "I see a 404 error" do
      default_user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(default_user)

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


feature "as an Admin" do
  describe "when I log into my account" do

    it "I am redirected to the Admin Dashboard" do
      admin = create(:platform_admin)

      visit login_path


      fill_in "session[email]", with: admin.email
      fill_in "session[password]", with: admin.password
      within(".action") do
        click_on("Login")
      end

      expect(page).to have_content("You're logged in as an Administrator.")

      expect(current_path).to eq(admin_dashboard_path)
    end
  end
end
