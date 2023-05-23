require 'rails_helper'

RSpec.describe "Movies Discover page" do
  before(:each) do
    test_data
  end
  describe "As a user, when I visit the movies discover page" do
    it "has a button to discover top rated movies", :vcr do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(@user_1)
      visit "/discover"

      within("#top-movies") do
        expect(page).to have_button("Find Top Rated Movies")
        click_button "Find Top Rated Movies"
      end

      expect(current_path).to eq("/users/#{@user_1.id}/movies")
    end

    it "can search by movie title", :vcr do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(@user_1)
      visit "/discover"

      within("#search-movies") do
        fill_in(:search, with: "Fight Club")
        click_button "Find Movies"
      end

      expect(current_path).to eq("/users/#{@user_1.id}/movies")
      expect(page).to have_content("Fight Club")
    end
  end
end
