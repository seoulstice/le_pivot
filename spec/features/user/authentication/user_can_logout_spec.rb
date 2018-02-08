 require 'rails_helper'

feature "Logout" do
	it "As a user, I can log out" do
    user = create(:user, password: 'password')
    visit root_path
    click_on 'Login'
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: 'password'
    within(".login-form") { click_on("Login") }

		click_on 'Logout'
		expect(page).to have_link("Login")
		expect(page).to_not have_link("Logout")
	end
end
