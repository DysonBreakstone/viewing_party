require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  describe "display" do
    before do
      test_data
    end

    it "has a list of user emails" do
      user = User.create!(name: "User", email: "email@email.com", password: "password123", password_confirmation: "password123", role: 1)
      allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
      
      visit "/admin/dashboard"
      
      expect(page).to have_content("#{user.name}'s Admin Dashboard")
      User.all.each do |default_user|
        expect(page).to have_link(default_user.email, href: admin_user_path(default_user))
      end
    end
    
    it "email link takes you to the user's dashboard page" do
      user = User.create!(name: "User", email: "email@email.com", password: "password123", password_confirmation: "password123", role: 1)
      allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
      
      visit "/admin/dashboard"
      
      click_on(@user_1.email)
      expect(current_path).to eq(admin_user_path(@user_1))
      expect(page).to have_content("#{@user_1.name}'s Dashboard")
    end
  end

  describe "default user does not have access" do
    before do
      test_data
    end

    it "user cannot access admin routes" do
      user = User.create!(name: "User", email: "email@email.com", password: "password123", password_confirmation: "password123")
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)
        
      visit "admin/dashboard"
      expect(page).to have_content("You are not authorized to view this page.")

      visit "admin/users/#{@user_1.id}"
      expect(page).to have_content("You are not authorized to view this page.")
    end
  end
end