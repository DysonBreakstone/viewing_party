# When a user visits the root path they should be on the landing page ('/') which includes:

#  Title of Application
#  Button to Create a New User
#  List of Existing Users which links to the users dashboard
#  Link to go back to the landing page (this link will be present at the top of all pages)

require 'rails_helper'

RSpec.describe "landing page" do
  describe "as a user, when I visit the landing page" do
    before(:each) do
      @user_1 = User.create!(name: "Katie", email: "email_address@gmail.com", password: "pass123")
      @user_2 = User.create!(name: "Steve", email: "email_address_2@gmail.com", password: "pass123")
      @user_3 = User.create!(name: "Stacey", email: "email_address_3@gmail.com", password: "pass123")
      @users = [@user_1, @user_2, @user_3]
      visit root_path
    end
    it "displays the title of the application" do
      within("#title") do
        expect(page).to have_content("Viewing Party")
      end
    end
    it "has a button to create a new user" do
      within("#new-user") do
        expect(page).to have_button("Create New User")
        click_button("Create New User")
      end

      expect(current_path).to eq("/register")
    end

    it "has a link to go back to the landing page" do
      within("#home") do
        expect(page).to have_link("Home")
        click_link "Home"
      end
      expect(current_path).to eq(root_path)
    end

    it "has a link to log in" do
      within("#login") do
        expect(page).to have_link("Log In")
      end
    end

    it "brings you to login page" do
      within("#login") do
        click_link("Log In")
        expect(current_path).to eq("/login")
      end
    end
  end
end
