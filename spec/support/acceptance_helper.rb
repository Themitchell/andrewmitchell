require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

require 'rspec'
require 'capybara/rspec'

module RequestMacros
  def login_as(user)
    page.driver.post user_session_path, :user => { :login => user.username, :password => user.password }
  end

  def logout
    page.driver.delete destroy_user_session_path
  end
end

RSpec.configure do |config|
  config.include RequestMacros, :type => :request

  config.after :each, :type => :request do
    logout
  end
end