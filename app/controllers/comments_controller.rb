class CommentsController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = Comment.new(params[:comment])
    @comment.micropost = @micropost
    @comment.user = current_user
    if @comment.save
       flash[:success] = "Comment created!"
       redirect_to current_user
    else
      render 'shared/_comment_form'
    end
  end
end
