require "rails_helper"

feature 'A user trying to log in' do
  let(:user) { create(:user, password: 'password') }

  background do
    visit login_path
    fill_in "session[email]", with: user.email
  end

  scenario "succeeds with valid credentials" do
    fill_in "session[password]", with: 'password'
    within(".login-form") { click_on("Login") }

    expect(page).to have_content "Welcome back, #{user.first_name}!"
    expect(current_path).to eq(dashboard_path)
    expect(page).to_not have_link "Login"
    expect(page).to have_link "Logout"
  end

  scenario "fails with no password" do
    within(".login-form") { click_on("Login") }

    expect(current_path).to eq(login_path)
    expect(page).to have_content "That login was unsuccessful"
  end

  scenario "fails with bad email/password combo" do
    fill_in "session[password]", with: 'wrong_password'
    within(".login-form") { click_on("Login") }

    expect(current_path).to eq(login_path)
    expect(page).to have_content "That login was unsuccessful"
  end

end
