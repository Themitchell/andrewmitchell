When /^I enter an URL "([^\"]*)"$/ do |url|
  visit url
end

Then /^The response status should be (\d+)$/ do |code|
  response.code.should == code
end