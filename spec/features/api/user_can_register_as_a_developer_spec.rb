require 'rails_helper'

feature 'Developer Settings' do

  scenario %{
    As a visitor
    When I visit "/settings/developer"
    Then I should be redirected to "/login"
  } do
    visit '/settings/developer'
    expect(page).to have_current_path('/login')
  end

  scenario %{
    As a logged in user
    When I visit "/Dashboard"
    And I click "Developer" (should be in the footer)
    And I click "Register"
    Then I should see an API key
    And my current path should still be "/settings/developer"
  } do

    stub_logged_in_user
    visit('/dashboard')
    within('footer') { click_on 'Developer' }
    click_on 'Register'

    expect(page).to have_current_path('/settings/developer')
    expect(page).to have_content(/api key: [\w\d\-]{22}/i)
  end

  scenario %{
    As a developer
    When I visit "/settings/developer"
    Then I should see my API Key
    And when I click "Reset API Key"
    Then I should see a new API key replace the old one
    And my current path should be still be "/settings/developer"
  } do
    old_api_key = create(:api_key, key: "a_22_character_api_key")
    stub_logged_in_user(old_api_key.user)
    visit '/settings/developer'

    expect(page).to have_content(old_api_key)
    click_on 'Reset API Key'
    expect(page).to have_content(/api key: [\w\d\-]{22}/i)
    expect(page).to_not have_content(old_api_key)
  end

end
