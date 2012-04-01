class PicturesController < ApplicationController
  before_filter :fetch_photoalbum
  
  PICTURES_PER_PAGE = 20
  
  def show
    @picture = @photoalbum.pictures.find_by_permalink(params[:id])
  end
  
  def tagged
    @tag = Tag.find_by_name(params[:tag])
    @tagged_pictures = @photoalbum.pictures.tagged_with(params[:tag], :on => :tags).paginate(:page => params[:page], :per_page => PICTURES_PER_PAGE)
  end
  
  private
  
  def fetch_photoalbum
    @photoalbum = Photoalbum.find_by_permalink(params[:photoalbum_id])
  end
end
