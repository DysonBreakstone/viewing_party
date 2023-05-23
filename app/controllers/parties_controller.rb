# Controller for parties
class PartiesController < ApplicationController
  def new
    # @user = User.find(session[:user_id])
    @movie = MovieFacade.new.find_movie(params[:movie_id])
    @users = User.all
  end

  def create
    party = PartyFacade.create_party(params)
    if party.save
      redirect_to controller: 'user_parties',
                  action: 'create',
                  participants: params[:participants],
                  party_host: session[:user_id],
                  movie: params[:movie_id],
                  party: party.id
    else
      redirect_to new_movie_party_path(params[:movie_id])
      flash[:alert] = "All fields must be filled out and party length must be greater than movie length"
    end
  end
end
