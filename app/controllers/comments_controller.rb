class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @commentable = find_commentable
    @comment = Comment.new
  end
  
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    
    @comment.author = current_user
    @comment.commentable = find_commentable
 
    if @comment.save
      flash[:notice] = 'Comment successfully created.'
      redirect_to redirection_path(@comment.commentable)
    else
      flash[:error] = "Comment was not created. Please check errors!"
      render :new
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id]);
    
    @comment.destroy();
    flash[:notice] = "Comment successfully removed."
    redirect_to redirection_path(@comment.commentable)
  end
  
  def find_commentable  
    params.each do |name, value|  
      if name =~ /(.+)_id$/  
        return $1.classify.constantize.find(value)  
      end  
    end  
    nil  
  end
  
  def redirection_path(commentable)
    if commentable.class.name == "Post"
      post_path(commentable)
    elsif   commentable.class.name == "Picture"
      picture_path(commentable)
    end
  end
end