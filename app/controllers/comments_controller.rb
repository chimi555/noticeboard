class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_comment_user, only: [:destroy]

  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @topic }
        format.js
      end
    else
      flash[:danger] = '新しいコメントの投稿に失敗しました。'
      redirect_to root_path
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @comment = Comment.find(params[:id])
    if @comment.destroy
      respond_to do |format|
        format.html { redirect_to @topic }
        format.js
      end
    else
      flash[:danger] = 'コメントの削除に失敗しました。'
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def correct_comment_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_path if @comment.nil?
  end
end
