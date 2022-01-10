class UsersController < ApplicationController
  def new
    @new_user = User.new
  end

  def create
    @new_user = User.new(new_user_params)
    if @new_user.save
      redirect_to login_path
    else
      render new_user_path
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
