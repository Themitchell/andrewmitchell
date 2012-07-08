class Admin::PostsController < Admin::AdminController

  before_filter :fetch_post,  :only => [:show, :edit, :update, :destroy]

  def index
    @posts = Post.order('created_at DESC').paginate(:page => params[:page], :per_page => ITEMS_PER_PAGE)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    @post.author = current_user
    if @post.save
      redirect_to admin_post_path(@post), :notice => "Successfully created post."
    else
      render :new, :error => "Could not create post. Check the errors and try again!"
    end
  end

  def edit
  end

  def update
    @post.author = current_user
    if @post.update_attributes(params[:post])
      redirect_to admin_post_path(@post), :notice => "Successfully updated post."
    else
      render :edit, :error => "Could not update post. Check the errors and try again!"
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] == "Successfully deleted post."
    else
      flash[:error] == "Could not delete post."
    end
    redirect_to admin_posts_path
  end

protected

  def fetch_post
    @post = Post.find_by_permalink! params[:id]
  end
end