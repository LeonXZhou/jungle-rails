class SessionsController < ApplicationController
  def new
  end

  def create
    if User.authenticate_with_credentials(params[:session][:email],params[:session][:password])
        @user = User.find_by_email(params[:session][:email])
       session[:user_id] = @user.id
       session[:user_email] = @user.email
       redirect_to :root
    else
       redirect_to login_path, notice: "Hey wrong login info!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
