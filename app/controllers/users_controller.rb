class UsersController < ApplicationController
  def new
    @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
    @notice = params[:notice]
    @errors = params[:errors]
  end

  def index
    redirect_to new_user_path
  end

  def create
    @new_user = User.new(new_user_params)
    if @new_user.save && (params[:user][:password] == params[:user][:password_confirmation])
      redirect_to login_path
    else
      @notice = nil
      if (params[:user][:password] != params[:user][:password_confirmation])
        @notice = "You're password did not match";
      end
      @error_messages = @new_user.errors.full_messages
      @new_user.destroy
      redirect_to new_user_path(notice: @notice, 
                                first_name: params[:user][:first_name],
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
    )
  end
end
