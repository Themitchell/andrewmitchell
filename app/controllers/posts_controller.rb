class PostsController < ApplicationController
  
  POSTS_PER_PAGE = 5
  
  def index
    @posts = Post.all(:order => 'published_on DESC').paginate(:page => params[:page], :per_page => POSTS_PER_PAGE)
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def tagged
    @tag = Tag.find_by_name(params[:tag])
    @tagged_posts = Post.tagged_with(params[:tag], :on => :tags).paginate(:page => params[:page], :per_page => POSTS_PER_PAGE)
  end
end
