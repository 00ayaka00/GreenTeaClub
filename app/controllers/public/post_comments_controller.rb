class Public::PostCommentsController < ApplicationController
  
  
   
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    
    if comment.save
      flash[:notice] = "コメントが投稿されました"
      # 通知の作成
      post.create_notification_post_comment!(current_user, comment.id)
      redirect_to post_path(post)
    else
      flash[:notice] = "コメントの投稿に失敗しました"
      redirect_to post_path(post)
    end 
  end
  
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end 
end