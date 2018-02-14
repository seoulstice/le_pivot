require 'rails_helper'

describe 'As a logged in Admin' do

  let(:platform_admin) { create(:platform_admin) }

  it 'I can modify my account data' do
    stub_logged_in_user(platform_admin)
    visit admin_dashboard_path
    click_on 'Update Account'
    fill_in 'user[email]', with: 'fake@example.com'
    fill_in 'user[password]', with: 'password'
    click_on 'Submit'
    click_on 'Logout'

    click_on 'Login'
    fill_in 'session[email]', with: 'fake@example.com'
    fill_in 'session[password]', with: 'password'
    within('.login-form') { click_on('Login') }

    expect(current_path).to eq('/admin/dashboard')
  end

  it 'But I cannot modify any other user’s account data' do
    stub_logged_in_user(platform_admin)
    visit dashboard_path(create(:user))

    expect(page).not_to have_content('Update account')
  end
end
