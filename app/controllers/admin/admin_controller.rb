class Admin::AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_all_users
  
  layout 'admin'
  
  def index
  end
  
  private
  
  def load_all_users
    @users = User.all
  end
end
