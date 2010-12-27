Given /^a user with email "([^\"]*)" and password "([^\"]*)"$/ do |email, password|
  Factory.create(:user, :email => email, :password => password, :password_confirmation => password)
end

Given /^I am logged in$/ do
  user = Factory.create(:user)
  visit new_user_session_path
  fill_in('user_email', :with => "user@example.com")
  fill_in('user_password', :with => "password")
  click_button('Sign in')
end

Given /^I am not logged in$/ do
  visit destroy_user_session_path
end

Given /^I log in as "([^\"]+)" using password "([^\"]+)"$/ do |email, password|
  Factory.create(:user, :email => email, :password => password, :password_confirmation => password)
  visit new_user_session_path
  fill_in('user_email', :with => email)
  fill_in('user_password', :with => password)
  click_button('Sign in')
end

Then /^I should be logged in$/ do
  page.body.include?('Sign out').should be_true
end

Then /^(?:I should be logged out|I should not be logged in)$/ do
  page.body.include?('Sign out').should be_false
end

