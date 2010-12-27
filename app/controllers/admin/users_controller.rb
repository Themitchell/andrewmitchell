class Admin::UsersController < Admin::AdminController  
  def index
    @users = User.admin.find(:all, :order => 'username ASC') + User.member.find(:all, :order => 'username ASC')
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    if params[:commit] == 'Remove'
      @user.image = nil
      @user.save!

      @user.attributes = params[:user]
      render :edit
    else
      params[:user][:avatar] = nil unless params[:user].has_key?(:avatar) || params.has_key?(:avatar)
       if @user.update_attributes(params[:user])
        flash[:notice] = "User successfully updated."
        redirect_to admin_user_path(@user)
      else
        flash.now[:error] = "User was not updated. Please check the errors."
        render_template :edit
      end
    end
  end
  
  def destroy
    @user = User.find(params[:id]);
    
    @user.destroy();
    flash[:notice] = "User successfully removed."
    redirect_to admin_users_path
  end
end