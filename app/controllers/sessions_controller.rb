class SessionsController < ApplicationController
  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  def login_user
    user = User.find_by(email: params[:email].downcase)
    if user
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:success] = "Session Started"
        redirect_to dashboard_path
      else
        flash[:error] = "Incorrect Password."
        redirect_to login_path
      end
    else
      flash[:error] = "An account with this email does not exist."
      redirect_to login_path
    end
  end
end