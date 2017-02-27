class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to :root
    else
      error = user.errors.messages.first[1][0]
      flash[:error] = possible_errors[error]
      redirect_to :signup
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def possible_errors
    {"has already been taken" => "Another user already has this email!",
     "doesn't match Password" => "Your passwords do not match!"}
  end
end
