class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @post = Post.find(params[:comment][:post_id])

    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
      redirect_to "/users/#{@post.author_id}/posts/#{@post.id}/"
    else
      flash[:notice] = 'Comment was not created.'
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    post = Post.find_by(id: @comment.post_id)
    post.comments_counter -= 1
    @comment.destroy!
    post.save
    flash[:success] = 'Comment Deleted!'
    redirect_to user_post_path(post.author_id, post.id)
  end


  private

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :text)
  end
end
