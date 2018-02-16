require "rails_helper"

describe "When visiting create store form" do
  context "as a registered User" do
    it "a user can create a store" do

      Seeder.new.create_roles
      stub_logged_in_user
      visit new_store_path
      fill_in "store[name]", with: "Vandelay Industries"
      click_on "Submit"
      expect(current_path).to eq(dashboard_path)
      click_on "My Stores"

      expect(current_path).to eq(stores_path)
      expect(page).to have_content("Vandelay Industries")
      expect(page).to have_content("pending")
    end
  end
end
