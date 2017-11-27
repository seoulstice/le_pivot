require "rails_helper"

describe "As a logged in Admin" do
  let(:admin) { create(:user, role: "admin")}

  it "I can modify my account data" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_index_path
    click_on "Update Account"
    fill_in "user[password]", with: "testing"
    fill_in "user[email]", with: "testerson@testmail.com"

    click_on "Submit"
    expect(admin.password).to eq("testing")
  end

    it "But I cannot modify any other user’s account data" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(admin)

      visit dashboard_index_path(user)

      expect(page).not_to have_content("Update account")
    end

    it "returns a welcome message for admins" do
      admin = create(:user, role: "admin")
      allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(admin)
      visit admin_dashboard_index_path
      expect(page).to have_content("You're logged in as an Administrator")
    end

    it "returns a 404 when a non-admin visits the admin dashboard" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(user)
      visit admin_dashboard_index_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
