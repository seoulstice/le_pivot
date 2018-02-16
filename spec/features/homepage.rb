require 'rails_helper'

feature "The homepage" do
  let!(:dove) { create(:item, title: "Dove", price: 5.00 }
  let!(:seal) { create(:item, title: "Seal", price: 100.00) }

  scenario "displays items with links to detail pages" do
    visit '/'
    expect(page).to have_content("Dove")
    expect(page).to have_content("$5.00")
    expect(page).to have_content("Seal")
    expect(page).to have_content("$100.00")
    expect(page).to have_link("Dove", href: item_path(dove))
  end

end
