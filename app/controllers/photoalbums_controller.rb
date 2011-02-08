class PhotoalbumsController < ApplicationController
  
  ALBUMS_PER_PAGE = 20
  
  def index
    @photoalbums = Photoalbum.all(:order => 'published_on DESC').paginate(:page => params[:page], :per_page => ALBUMS_PER_PAGE)
  end
  
  def show
    @photoalbum = Photoalbum.find_by_id(params[:id])
  end
end