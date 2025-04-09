class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def favorites
    @user = User.find(params[:id])
    @posts = @user.favorite_posts
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.following_users
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.follower_users
  end
  
  def guest_login
    @user = User.guest
    sign_in(@user)
    redirect_to root_path
  end
end
