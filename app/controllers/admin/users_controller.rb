class Admin::UsersController < ApplicationController
  def dashboard
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end