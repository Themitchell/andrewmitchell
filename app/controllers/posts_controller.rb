class PostsController < ApplicationController

  POSTS_PER_PAGE = 6

  def index
    @posts = Post.order('published_on DESC').paginate(:page => params[:page], :per_page => POSTS_PER_PAGE)
  end

  def show
    @post = Post.find_by_permalink params[:id]
  end

  def category
    @category = Category.find_by_permalink params[:category_permalink]
    @posts = Post.from_category(@category).order('published_on DESC').paginate(:page => params[:page], :per_page => POSTS_PER_PAGE)
    render :template => 'posts/index'
  end

  def tagged
    @tag = Tag.find_by_name params[:tag]
    @tagged_posts = Post.tagged_with(params[:tag], :on => :tags).paginate(:page => params[:page], :per_page => POSTS_PER_PAGE)
  end
end
