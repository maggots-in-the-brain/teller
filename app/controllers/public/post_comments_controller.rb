class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params.merge(post: @post))
    if @post_comment.save!
      flash[:notice] = "コメントしました"
      redirect_back(fallback_location: root_url)
    else
      flash[:alert] = "コメントに失敗しました"
      redirect_back(fallback_location: root_url)
    end
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    post = post_comment.post
    redirect_to post
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
