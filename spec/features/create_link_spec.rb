require "rails_helper"

RSpec.describe "can create links", :js => :true do
  scenario "Create a new link" do
    stub_logged_in_user

    fill_in "Title:", :with => "Turing"
    fill_in "URL:", :with => "http://turing.io"
    click_on "Add Link"

    within('#links-list') do
      expect(page).to have_text("Turing")
      expect(page).to have_text("http://turing.io")
    end
  end

  scenario "Cannot create link with invalid URL" do
    stub_logged_in_user

    expect(User.first.links.count).to eq(0)

    fill_in "Title:", :with => "Turing"
    fill_in "URL:", :with => "ht.turing.io"
    click_on "Add Link"

    expect(page).to have_content("Please enter a valid URL")
    expect(User.first.links.count).to eq(0)
  end
end
