require "rails_helper"

RSpec.describe "user can sign up" do
  scenario "User signs up before anything" do
    visit "/"
    click_on "Sign Up"

    expect(current_path).to eq(new_user_path)

    fill_in "Email", :with => "cdun@gmail.com"
    fill_in "Password", :with => "texas"
    fill_in "Password confirmation", :with => "texas"
    click_on "Create Account"

    expect(current_path).to be("/")
    expect(User.all.first.email).to eq("cdun@gmail.com")
  end
end
