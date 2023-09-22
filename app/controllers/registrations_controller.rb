class RegistrationsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
    @user = User.new
  end

  def create
    @user = User.create(params.require(:user).permit(:email, :password))
    session[:user_id] = @user.id
    redirect_to books_path
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
