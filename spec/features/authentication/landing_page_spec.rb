require 'rails_helper'

RSpec.describe "Authentication" do
  describe "landing page display" do
    before do
      test_data
    end

    it "no existing users section for nonregistered visitors" do
      visit root_path
      User.all.each do |user|
        expect(page).to have_no_content(user.email)
      end
    end

    it "only email addresses appear for registered users, without links" do
      visit root_path
      click_on("Log In")
      fill_in :email, with: "#{@user_1.email}"
      fill_in :password, with: "#{@user_1.password}"
      click_on "Log In"
      click_on "Home"

      User.all.each do |user|
        expect(page).to have_content(user.email)
        expect(page).to_not have_link(user.email)
      end
    end
  end
end