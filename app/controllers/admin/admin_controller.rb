class Admin::AdminController < ApplicationController
  layout 'admin'

  before_filter :authenticate_user!
  before_filter :require_admin

  ITEMS_PER_PAGE = 20

  def require_superadmin
    unless current_user.is_superadmin?
      flash[:notice] = "You must be a superadmin to access this page"
      redirect_to root_path
      return false
    end
  end

  def require_admin
    if current_user
      unless current_user.is_admin? || current_user.is_superadmin?
        flash[:notice] = "You must be an admin to access this page"
        redirect_to root_path
        return false
      end
    else
      authenticate_user!
    end
  end

end
