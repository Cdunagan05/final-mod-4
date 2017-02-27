require "rails_helper"

RSpec.describe "user can login" do
  scenario "User logs in" do
    user = User.create(email: "cdunagan@gmail.com", password_digest: "texas")
    visit "/"
    click_on "Login"

    expect(current_path).to eq(login_path)

    fill_in "email", :with => "cdunagan@gmail.com"
    fill_in "password", :with => "texas"
    click_on "Submit"

    expect(current_path).to eq(root_path)
    expect(User.all.first.email).to eq("cdunagan@gmail.com")
  end

  scenario "User logs out" do
    user = User.create(email: "cdunagan@gmail.com", password_digest: "texas")
    visit "/"
    click_on "Login"

    expect(current_path).to eq(login_path)

    fill_in "email", :with => "cdunagan@gmail.com"
    fill_in "password", :with => "texas"
    click_on "Submit"

    expect(current_path).to eq(root_path)

    click_on "Logout"

    expect(current_path).to eq(login_path)
  end
end
