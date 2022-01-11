class UsersController < ApplicationController
  def new
    @new_user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
    @errors = params[:errors] ? params[:errors] : []
  end

  def index
    redirect_to new_user_path
  end

  def create
    @new_user = User.new(new_user_params)
    if @new_user.save
      redirect_to login_path
    else
      @error_messages = @new_user.errors.full_messages
      @new_user.destroy #need to destroy or else we'll get email in use on the next save
      redirect_to new_user_path(first_name: params[:user][:first_name],
                                last_name: params[:user][:last_name],
                                email: params[:user][:email],
                                errors: @error_messages)
    end
  end

  private

  def new_user_params

    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
