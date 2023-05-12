class UserPartiesController < ApplicationController
  def create
    @party = Party.find(params[:party])
    @party.user_parties.create(user_id: params[:party_host], is_host: true)
    params[:participants].each do |participant|
      @party.user_parties.create(user_id: participant)
    end

    redirect_to "/users/#{params[:party_host]}"
  end
end