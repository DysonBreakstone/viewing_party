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
        expect(page).to have_no_content(user.name)
      end
    end
  end
end