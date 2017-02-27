class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      session[:user_id] = user.id
      flash[:success] = "Succesfully logged in!"
      redirect_to :root
    else
      flash[:error] = "Unsuccessful login, please try again or GTFO, you can't steal their password or email!"
      redirect_to :login
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
