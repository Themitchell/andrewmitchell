class Admin::PostsController < Admin::AdminController
  before_filter :fetch_post,  :only => [:edit, :update, :destroy]

  def index
    @posts = Post.order('created_at DESC').paginate(:page => params[:page], :per_page => ITEMS_PER_PAGE)
  end

  def new
    @post = Post.new(params[:post])
  end

  def create
    @post = Post.new(params[:post])
    @post.author = current_user

    if @post.save
      flash[:notice] == "Post successfully created."
      redirect_to post_path @post
    else
      flash[:error] == "Post could not be created."
      render :new
    end
  end

  def edit
  end

  def update
    attributes_hash = params[:post].merge(:author_id => current_user.id)

    if @post.update_attributes attributes_hash
      flash[:notice] == "Post successfully updated."
      redirect_to post_path @post
    else
      flash[:error] == "Post could not be updated."
      render :edit
    end
  end


  def destroy
    if @post.destroy
      flash[:notice] == "Post successfully deleted."
    else
      flash[:error] == "Post could not be deleted."
    end
    redirect_to admin_posts_path
  end

  # protected

  def fetch_post
    @post = Post.find_by_permalink! params[:id]
  end

end
