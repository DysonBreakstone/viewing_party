require 'rails_helper'

RSpec.describe "user registration page", type: :feature do
  describe "display" do
    it "has new user form" do
      visit '/register'

      expect(page).to have_content("Register a New User")

      expect(page).to have_field("Name:")
      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
      expect(page).to have_button("Create User")
    end
  end

  describe "function" do
    it "registers new user" do
      visit '/register'

      fill_in("Name:", with: "Barbara")
      fill_in("Email", with: "BarbarasEmail@Email.com")
      fill_in("Password", with: "babaras_password")
      fill_in("PasswordConfirmation", with: "babaras_password")
      click_button("Create User")

      user = User.last
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Barbara's Dashboard")
    end
  end

  describe "sad path" do
    it "email not unique" do
      visit '/register'

      fill_in("Name:", with: "Barbara")
      fill_in("Email", with: "BarbarasEmail@Email.com")
      click_button("Create User")

      visit '/register'

      fill_in("Name:", with: "John")
      fill_in("Email", with: "BarbarasEmail@Email.com")
      click_button("Create User")

      expect(current_path).to eq('/register')
      expect(page).to have_content("Password can't be blank")
    end

    it "fields not filled out" do
      visit '/register'

      fill_in("Name:", with: "Barbara")
      click_button("Create User")

      expect(current_path).to eq('/register')
      expect(page).to have_content("Email can't be blank, Password digest can't be blank, Email is invalid, and Password can't be blank")
    end

    it "not valid email" do
      visit '/register'

      fill_in("Name:", with: "John")
      fill_in("Email", with: "kjshdfkjshdf")
      fill_in("Password", with: "password")
      fill_in("PasswordConfirmation", with: "password")
      click_button("Create User")

      expect(current_path).to eq('/register')
      expect(page).to have_content("Email is invalid")
    end

    it "no password" do
      visit '/register'

      fill_in("Name:", with: "Barbara")
      fill_in("Email", with: "BarbarasEmail@Email.com")
      click_button("Create User")

      expect(current_path).to eq('/register')
      expect(page).to have_content("Password can't be blank")
    end

    it "passwords don't match" do
      visit '/register'

      fill_in("Name:", with: "Barbara")
      fill_in("Email", with: "BarbarasEmail@Email.com")
      fill_in("Password", with: "unique_password")
      fill_in("PasswordConfirmation", with: "unique_password123")
      click_button("Create User")

      expect(current_path).to eq('/register')
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
