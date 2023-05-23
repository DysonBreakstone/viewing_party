require 'rails_helper'

RSpec.describe "log out" do
  before do
    user = User.create!(name: "User", email: "email@email.com", password: "password123", password_confirmation: "password123")
    visit login_path
    
    fill_in :email, with: "#{user.email}"
    fill_in :password, with: "#{user.password}"
    click_on "Log In"

    expect(current_path).to eq("/users/#{user.id}")
    expect(page).to have_content("Session Started")
    visit root_path
  end

  it "login and create account clickables disappear and login button appears" do
    expect(page).to_not have_button("Create New User")
    expect(page).to_not have_link("Log In")
    expect(page).to have_button("Log Out")
  end

  it "logs out user and returns to landing page" do
    click_on("Log Out")

    expect(current_path).to eq(root_path)
    expect(page).to have_button("Create New User")
    expect(page).to have_link("Log In")
  end
end