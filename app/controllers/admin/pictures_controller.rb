class Admin::PicturesController < Admin::AdminController
  
  def index
    @pictures = Picture.all(:order => 'published_on DESC')
  end
  
  def show
    @picture = Picture.find_by_id(params[:id])
  end
  
  def new
    @picture = Picture.new
  end
  
  def create
    @picture = Picture.new(params[:picture])
    if @picture.save
      flash[:notice] = "Picture successfully created."
      redirect_to admin_picture_path(@picture)
    else
      flash[:error] = "Picture was not created. Please check the errors"
      render :new
    end
  end
  
  def edit
    @picture = Picture.find_by_id(params[:id])
  end
  
  def update
    @picture = Picture.find(params[:id])
    @picture.update_attributes(params[:picture])
    if @picture.save
      flash[:notice] = "Picture successfully updated."
      redirect_to admin_picture_path(@picture)
    else
      flash[:error] = "Picture was not updated. Please check the errors."
      render :edit
    end
  end
  
  def destroy
    @picture = Picture.find(params[:id])
    
    @picture.destroy()
    flash[:notice] = "Picture successfully removed."
    redirect_to admin_pictures_path
  end
end