# Controller for parties
class PartiesController < ApplicationController
  def new
    if current_user
      @movie = MovieFacade.new.find_movie(params[:movie_id])
      @users = User.all
    else
      redirect_to movie_path(params[:movie_id])
      flash[:alert] = "Must be logged in to create a viewing party"
    end
  end

  def create
    party = PartyFacade.create_party(params)
    if party.save
      redirect_to controller: 'user_parties',
                  action: 'create',
                  participants: params[:participants],
                  party_host: current_user,
                  movie: params[:movie_id],
                  party: party.id
    else
      redirect_to new_movie_party_path(params[:movie_id])
      flash[:alert] = "All fields must be filled out and party length must be greater than movie length"
    end
  end
end
