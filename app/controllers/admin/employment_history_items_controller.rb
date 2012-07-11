class Admin::EmploymentHistoryItemsController < Admin::AdminController

  before_filter :fetch_employment_history_item,  :only => [:show, :edit, :update, :destroy]

  def index
    @employment_history_items = EmploymentHistoryItem.order('created_at DESC').paginate(:page => params[:page], :per_page => ITEMS_PER_PAGE)
  end

  def show
  end

  def new
    @employment_history_item = EmploymentHistoryItem.new
  end

  def create
    @employment_history_item = EmploymentHistoryItem.new(params[:employment_history_item])

    if @employment_history_item.save
      redirect_to admin_employment_history_item_path(@employment_history_item), :notice => "Successfully created employment history item."
    else
      render :new, :error => "Could not create employment history item. Check the errors and try again!"
    end
  end

  def edit
  end

  def update
    if @employment_history_item.update_attributes(params[:employment_history_item])
      redirect_to admin_employment_history_item_path(@employment_history_item), :notice => "Successfully updated employment history item."
    else
      render :edit, :error => "Could not update employment history item. Check the errors and try again!"
    end
  end

  def destroy
    if @employment_history_item.destroy
      flash[:notice] == "Successfully deleted employment history item."
    else
      flash[:error] == "Could not delete employment history item."
    end
    redirect_to admin_employment_history_items_path
  end

protected

  def fetch_employment_history_item
    @employment_history_item = EmploymentHistoryItem.find params[:id]
  end
end