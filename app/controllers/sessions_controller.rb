class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to books_path
    else
      redirect_to root_path
    end
  end

  def page_requires_login
  end

  def welcome
  end

  # def destroy
  #   session.delete :user_id
  #   redirect_to root_path, flash: { success: "Logged Out" }
  # end

  def destroy
    session.delete :user_id
    flash[:success] = "Logged Out"
    render 'sessions/new'
  end
  
end
