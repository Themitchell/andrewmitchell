class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  before_filter :fetch_categories

  private

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
