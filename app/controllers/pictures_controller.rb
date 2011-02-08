class PicturesController < ApplicationController
  
  PICTURES_PER_PAGE = 20
  
  def index
    @pictures = Picture.all(:order => 'published_on DESC').paginate(:page => params[:page], :per_page => PICTURES_PER_PAGE)
  end
  
  def show
    @picture = Picture.find_by_id(params[:id])
  end
  
  def tagged
    @tag = Tag.find_by_name(params[:tag])
    @tagged_pictures = Picture.tagged_with(params[:tag], :on => :tags).paginate(:page => params[:page], :per_page => PICTURES_PER_PAGE)
  end
end
