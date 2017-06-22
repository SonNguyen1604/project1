class CommentsController < ApplicationController
  def create
    @micropost = Micropost.find_by id: params[:micropost_id]
    @comment = @micropost.comments
      .build content: params[:comment][:content], user: current_user

    if @comment.save
      flash[:success] = t ".commented"
    else
      @comment.errors.add :content, t(".content_not_nil")
      flash[:danger] = t ".fail_comment"
    end
    redirect_to :back
  end

  def destroy
    @comment = Comment.find_by id: params[:id]
    if @comment.destroy
      flash[:success] = t ".comment_deleted"
    else
      flash[:danger] = t ".fail_delete"
    end
    redirect_to :back
  end
end
