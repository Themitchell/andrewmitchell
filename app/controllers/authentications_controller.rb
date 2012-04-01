class AuthenticationsController < ApplicationController
  before_filter :must_be_logged_in, :only => [:index, :destroy]
  
  def index
    @authentications = current_user.authentications
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    
    if authentication
      flash[:notice] = "You have successfully signed in with #{omniauth['provider'].titleize}."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "You have successfully connected your account with #{omniauth['provider'].titleize}."
      redirect_to authentications_path
    else      
      if user = User.find_by_email(omniauth['info']['email'])
        user.apply_omniauth(omniauth)
        if user.save
          flash[:notice] = "We found an account an matching account from your #{omniauth['provider'].titleize} account's email, so we've linked them for you."
          sign_in_and_redirect(:user, user)
        else
          flash[:error] = "Oops, something borked it!"
          redirect_to new_user_registration_url
        end
      else
        user = User.new(
          :role => 'member',
          :email => omniauth['info']['email'].nil? ? "" : omniauth['info']['email'],
          :username => omniauth['info']['nickname']
        )
        user.apply_omniauth(omniauth)
        if user.save
          flash[:notice] = "You have successfully created an account from your #{omniauth['provider'].titleize} account."
          sign_in_and_redirect(:user, user)
        else
          session[:omniauth] = omniauth.except('extra')
          redirect_to new_user_registration_url
        end
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find_by_provider(params[:provider])
    @authentication.destroy
    flash[:notice] = "You have successfully disconnected your account from #{params[:provider]}"
    redirect_to authentications_path
  end
end
