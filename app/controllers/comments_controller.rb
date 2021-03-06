class CommentsController < ApplicationController
  def create
    @rhetoric = Rhetoric.find(params[:rhetoric_id])
    @comment = @rhetoric.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      render :index
    end

  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :index
    end
  end

    private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :rhetoric_id)
  end
end
