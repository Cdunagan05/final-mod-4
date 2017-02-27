require "rails_helper"

RSpec.describe "can edit links" do
  scenario "User can edit link" do
    stub_logged_in_user

    fill_in "url", with: 'https://orangebloods.com'
    fill_in "title", with: "Texas Longhorns"
    click_on "Submit Link"

    expect(current_path).to eq(root_path)
    expect(User.first.links.count).to eq(1)

    click_on "Edit Link"

    expect(current_path).to eq(edit_link_path(User.first.links.first[:id]))

    fill_in "url", with: 'https://bluebloods.com'
    fill_in "title", with: "College Royalty"
    click_on "Update Link"


    expect(page).to have_content("College Royalty")
    expect(page).to have_content("https://bluebloods.com")
  end
end
