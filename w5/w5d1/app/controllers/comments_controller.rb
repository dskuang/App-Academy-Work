class CommentsController < ApplicationController


  def create

    @comment = Comment.new(comment_params)
    new_link = "/#{@comment.commentable_type.tableize}/#{@comment.commentable_id}"
    if @comment.save
      redirect_to new_link
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_link
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to "/#{@comment.commentable_type.tableize}/#{@comment.commentable_id}"
    else
      flash[:errors] = "booo"
      redirect_to edit_comment_url(@comment)
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end

  def destroy
    @comment = Comment.find(params[:id])
    Comment.find(params[:id]).destroy
    redirect_to "/#{@comment.commentable_type.tableize}/#{@comment.commentable_id}"
  end
end
