Given /^I have a user named "([^"]*)"$/ do |username|
  Factory.create(:user, :username => username)
end

Given /^I have a user named "([^"]*)" with role "([^"]*)"$/ do |username, role|
  Factory.create(:user, :username => username, :role => role)
end

Given /^I am logged in as "([^"]*)"$/ do |username|
  user = User.find_by_username("#{username}")
  visit new_user_session_path
  fill_in('user_email', :with => user.email)
  fill_in('user_password', :with => "password")
  click_button('Sign in')
end

Then /^there should( not|) be a user with username "([^"]*)"$/ do |see_or_not, username|
  user = User.find_by_username("#{username}")
  if see_or_not.blank?
    user.should_not be_nil
  elsif
    user.should be_nil
  end
end
