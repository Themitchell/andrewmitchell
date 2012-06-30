class Admin::AdminController < ApplicationController
  layout 'admin'

  before_filter :require_admin

  def require_superadmin
    authenticate_user!
    unless current_user.is_superadmin?
      flash[:notice] = "You must be a superadmin to access this page"
      redirect_to root_path
      return false
    end
  end

  def require_admin
    authenticate_user!
    unless current_user.is_admin? || current_user.is_superadmin?
      flash[:notice] = "You must be an admin to access this page"
      redirect_to root_path
      return false
    end
  end

end
