class ProfileController < ApplicationController
  # before_action :authorized

  def show
    @user = current_user
    @profile = @user.profile
  end
end
