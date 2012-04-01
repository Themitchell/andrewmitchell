class PhotoalbumsController < ApplicationController
  
  ALBUMS_PER_PAGE = 20
  
  def index
    @photoalbums = Photoalbum.order('published_on DESC').paginate(:page => params[:page], :per_page => ALBUMS_PER_PAGE)
  end
  
  def show
    @photoalbum = Photoalbum.find_by_permalink(params[:id])
    @photoalbum.pictures.order('published_on DESC').paginate(:page => params[:page], :per_page => ALBUMS_PER_PAGE)
  end
end