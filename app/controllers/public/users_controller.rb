class Public::UsersController < ApplicationController
  def guest_login
    @user = User.guest
    sign_in(@user)
    redirect_to root_path
  end
end
