require "rails_helper"

RSpec.describe "can create links", :js => :true do
  scenario "Create a new link" do
    stub_logged_in_user

    fill_in "url", with: 'https://orangebloods.com'
    fill_in "title", with: "Texas Longhorns"
    click_on "Submit Link"

    expect(current_path).to eq(root_path)
    expect(User.first.links.count).to eq(1)


    expect(page).to have_content("Texas Longhorns")
    expect(page).to have_content("https://orangebloods.com")
  end

  scenario "Cannot create link with invalid URL" do
    stub_logged_in_user

    expect(User.first.links.count).to eq(0)

    fill_in "url", with: 'orangebloods.com'
    fill_in "title", with: "Texas Longhorns"
    click_on "Submit Link"

    expect(User.first.links.count).to eq(0)
    expect(page).to have_content("You entered an invalid URL, please try again")
  end
end
