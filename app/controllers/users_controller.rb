class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.create_profile
      session[:user_id] = @user.id
      redirect_to books_path
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
