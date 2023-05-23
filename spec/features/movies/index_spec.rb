require 'rails_helper'

RSpec.describe "Movies Results page" do
  before(:each) do
    test_data
    test_movie
    @movie = Movie.new(test_movie)
  end
  describe "As a user, when I visit the movie results page from the discover movies page" do
    it "displays the movie title as a link to the movie details page", :vcr do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(@user_1)
      visit "/discover"

      within("#search-movies") do
        fill_in(:search, with: @movie.title.to_s)
        click_button "Find Movies"
      end

      within("#results") do
        expect(page).to have_link(@movie.title.to_s)
        click_link @movie.title.to_s
      end

      expect(current_path).to eq(movie_path(@movie.id))
    end

    it "displays the vote average of the movie", :vcr do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(@user_3)
      visit "/discover"

      within("#search-movies") do
        fill_in(:search, with: @movie.title.to_s)
        click_button "Find Movies"
      end

      within("#movie-#{@movie.id}") do
        expect(page).to have_content("Vote Average: #{@movie.vote_average}")
      end
    end

    it "has a button to return to the discover page", :vcr do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(@user_1)
      visit "/users/#{@user_1.id}/movies"

      expect(page).to have_button("Discover Page")
      click_button "Discover Page"
      expect(current_path).to eq("/discover")
    end

    it "displays top rated movies if chosen from discover page", :vcr do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(@user_3)
      visit "/discover"

      within("#top-movies") do
        click_button "Find Top Rated Movies"
      end

      within("#results") do
        expect(page).to have_content("The Godfather")
        expect(page).to have_content("The Shawshank Redemption")
        expect(page).to have_content("The Godfather Part II")
      end
    end

    it "displays a message if there are no movie search results" do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(@user_1)
      visit "/users/#{@user_1.id}/movies"

      within("#results") do
        expect(page).to have_content("No results.")
      end
    end
  end
end
