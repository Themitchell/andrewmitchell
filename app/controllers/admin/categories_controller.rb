class Admin::CategoriesController < Admin::AdminController

  before_filter :fetch_category,  :only => [:show, :edit, :update, :destroy]

  def index
    @categories = Category.order('created_at DESC').paginate(:page => params[:page], :per_page => ITEMS_PER_PAGE)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    @category.author = current_user

    if @category.save
      redirect_to admin_category_path(@category), :notice => "Successfully created category."
    else
      render :new, :error => "Could not create category. Check the errors and try again!"
    end
  end

  def edit
  end

  def update
    @category.author = current_user
    if @category.update_attributes(params[:category])
      redirect_to admin_category_path(@category), :notice => "Successfully updated category."
    else
      render :edit, :error => "Could not update category. Check the errors and try again!"
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] == "Successfully deleted category."
    else
      flash[:error] == "Could not delete category."
    end
    redirect_to admin_categories_path
  end

protected

  def fetch_category
    @category = Category.find_by_permalink! params[:id]
  end
end