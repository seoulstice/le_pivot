require "rails_helper"

feature "When visiting create store form" do
  scenario "A registered user can create a store" do

    Seeder.create_roles
    stub_logged_in_user
    visit dashboard_path
    click_on "My Stores"
    click_on "new store"
    fill_in "store[name]", with: "Vandelay Industries"
    click_on "Submit"

    expect(current_path).to eq(dashboard_path)
    click_on "My Stores"

    expect(current_path).to eq(stores_path)
    expect(page).to have_content("Vandelay Industries")
    expect(page).to have_content("pending")

  end
end
