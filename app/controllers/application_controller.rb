class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  
  before_filter :fetch_categories

  private
  
  def must_be_logged_in
    if user_signed_in?
      return true
    else
      flash[:error] = "Sorry, you must be logged in to view that page."
      redirect_to login_path
    end
  end
  
  def throw_404
    render :file => "#{RAILS_ROOT}/public/404.html", :layout => false, :status => 404
  end

  def throw_403
    render :file => "#{RAILS_ROOT}/public/403.html", :layout => false, :status => 403
  end
  
  def fetch_categories
    @categories = Category.order('name ASC').all
  end
end
