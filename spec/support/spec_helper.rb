ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.include Devise::TestHelpers, :type => :controller
end
