# controller for data from movies API
class MoviesController < ApplicationController
  # before_action :find_user, only: [:discover, :index, :show]

  def discover; end

  def index
    @movies = if params[:search].present?
                MovieFacade.new.find_movies(params[:search])
              elsif params[:q] == "top20rated"
                MovieFacade.new.top_rated_movies
              end
  end

  def show
    @facade = MovieFacade.new
    @movie = @facade.find_movie(params[:id])
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
