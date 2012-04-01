class UsersController < ApplicationController

  before_filter :authenticate_user!, :except => [:create]
  respond_to :html

  def create
    user = params[:user]
    user.role = "member"
    @user = User.new(user)
    if @user.save
      flash[:notice] = "User successfully created."
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    
    if params[:commit] == 'Remove'
      @user.avatar = nil
      @user.save!

      @user.attributes = params[:user]
      render :show
    else
      params[:user][:avatar] = nil unless params[:user].has_key?(:avatar) || params.has_key?(:has_avatar)
       if @user.update_attributes(params[:user])
        flash[:notice] = 'User successfully updated.'
        redirect_to user_path(@user)
      else
        flash.now[:error] = 'Could not update details:'
        render :edit
      end
    end
  end
end
