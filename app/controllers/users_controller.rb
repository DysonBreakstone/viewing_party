# controller for users in database
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_data = user_params
    user_data[:email] = user_data[:email].downcase
    @user = User.new(user_data)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      redirect_to "/register"
      flash[:alert] = @user.errors.full_messages.to_sentence
    end
  end

  def login_form
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

  # def logout_user
  #   session[:user]
  # end

  def dashboard
    # @user = User.find(params[:user_id])
    @facade = MovieFacade.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
