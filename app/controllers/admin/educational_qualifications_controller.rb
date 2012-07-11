class Admin::EducationalQualificationsController < Admin::AdminController

  before_filter :fetch_educational_qualification,  :only => [:show, :edit, :update, :destroy]

  def index
    @educational_qualifications = EducationalQualification.order('created_at DESC').paginate(:page => params[:page], :per_page => ITEMS_PER_PAGE)
  end

  def show
  end

  def new
    @educational_qualification = EducationalQualification.new
  end

  def create
    @educational_qualification = EducationalQualification.new(params[:educational_qualification])

    if @educational_qualification.save
      redirect_to admin_educational_qualification_path(@educational_qualification), :notice => "Successfully created educational qualification."
    else
      render :new, :error => "Could not create educational qualification. Check the errors and try again!"
    end
  end

  def edit
  end

  def update
    if @educational_qualification.update_attributes(params[:educational_qualification])
      redirect_to admin_educational_qualification_path(@educational_qualification), :notice => "Successfully updated educational qualification."
    else
      render :edit, :error => "Could not update educational qualification. Check the errors and try again!"
    end
  end

  def destroy
    if @educational_qualification.destroy
      flash[:notice] == "Successfully deleted educational qualification."
    else
      flash[:error] == "Could not delete educational qualification."
    end
    redirect_to admin_educational_qualifications_path
  end

protected

  def fetch_educational_qualification
    @educational_qualification = EducationalQualification.find params[:id]
  end
end