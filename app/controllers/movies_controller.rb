# controller for data from movies API
class MoviesController < ApplicationController
  before_action :find_user, only: [:discover, :index]

  def discover; end

  def index
    @movies = if params[:search].present?
                MovieFacade.new.find_movies(params[:search])
              else
                MovieFacade.new.top_rated_movies
              end
  end

  def show; end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
