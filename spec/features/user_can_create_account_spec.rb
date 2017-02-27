require "rails_helper"

RSpec.describe "user can sign up" do
  scenario "User signs up before anything" do
    visit "/"
    click_on "Sign-up"

    expect(current_path).to eq(signup_path)

    fill_in "user_email", :with => "cdun@gmail.com"
    fill_in "user_password", :with => "texas"
    fill_in "user_password_confirmation", :with => "texas"
    click_on "Submit"

    expect(current_path).to eq(root_path)
    expect(User.all.first.email).to eq("cdun@gmail.com")
  end
end
