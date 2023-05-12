require 'rails_helper'

RSpec.describe MovieFacade do
  before(:each) do
    @mf = MovieFacade.new
  end
  describe "initialize" do
    it "exists" do
      expect(@mf).to be_a MovieFacade
    end
  end
  describe "find_movies" do
    it "returns a list of movies based on a search query", :vcr do
      movies = @mf.find_movies("fight")
      expect(movies).to all be_a Movie
      expect(movies.count <= 20).to be true
      results = movies.map do |movie|
        movie.title.downcase.include? "fight"
      end
      expect(results).to all be true
    end
  end
  describe "top_rated_movies" do
    it "returns a list of the top rated movies", :vcr do
      movies = @mf.top_rated_movies
      expect(movies).to all be_a Movie
      expect(movies.count <= 20).to be true
      expect(movies.first.title).to eq("The Godfather")
    end
  end
end