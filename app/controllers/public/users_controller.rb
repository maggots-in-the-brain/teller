class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def favorites
    @user = User.find(params[:id])
    @posts = @user.favorite_posts
  end

  def guest_login
    @user = User.guest
    sign_in(@user)
    redirect_to root_path
  end
end
