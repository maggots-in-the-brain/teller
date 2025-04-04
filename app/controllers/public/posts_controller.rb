class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
    if params[:keyword].present?
      @posts = @posts.where('title LIKE(?)', "%#{params[:keyword]}%").or(
        @posts.where('address LIKE(?)', "%#{params[:keyword]}%")
      )
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "保存しました"
      redirect_to @post
    else
      flash.now[:alert] = "保存に失敗しました"
      render :new
    end
  end

  def edit
  end
  
  def update
    if @post.update(post_params)
      flash[:notice] = "保存しました"
      redirect_to @post
    else
      flash.now[:alert] = "保存に失敗しました"
      render :edit
    end
  end
  
  def destroy
    @post.destroy
    flash[:notice] = "削除しました"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :address, :latitude, :longitude)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url unless @post
  end
end
