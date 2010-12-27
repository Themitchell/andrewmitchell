class Admin::PostsController < Admin::AdminController
  
  def index
    @posts = Post.all(:order => 'published_on DESC')
  end
  
  def show
    @post = Post.find_by_id(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    
    if @post.save
      flash[:notice] = "Post successfully created."
      redirect_to admin_post_path(@post)
    else
      flash[:error] = "Post was not created. Please check the errors"
      render :new
    end
  end
  
  def edit
    @post = Post.find_by_id(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    if @post.save
      flash[:notice] = "Post successfully updated."
      redirect_to admin_post_path(@post)
    else
      flash[:error] = "Post was not updated. Please check the errors."
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    
    @post.destroy()
    flash[:notice] = "Post successfully removed."
    redirect_to admin_posts_path
  end
end