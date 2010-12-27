Then /^I should see (an|a) "([^\"]*)" size image with file name "([^\"]*)" and alt tag "([^\"]*)"$/ do |an_a,image_size, file_name, alt_text|
  xpath = ".//img[contains(@src, '#{image_size}/#{file_name}') and @alt='#{alt_text}']"
  page.should have_xpath(xpath)
end

Then /^I should see an image with file name "([^\"]*)" and alt tag "([^\"]*)"$/ do |file_name, alt_text|
  xpath = ".//img[contains(@src, '#{file_name}') and @alt='#{alt_text}']"
  page.should have_xpath(xpath)
end

Then /^I should (not |)see "([^\"]*)" in the (.*)$/ do |see_or_not, text, section_name|
  within(:xpath, xpath_of_section(section_name)) do
    if see_or_not.blank?
      page.should have_content(text)
    else
      page.should_not have_content(text)
    end
  end
end

Then /^I should (not |)see a form in the (.*)$/ do |see_or_not, section_name|
  xpath = ".//form"
  within(:xpath, xpath_of_section(section_name)) do
    if see_or_not.blank?
      page.should have_xpath(xpath)
    else
      page.should_not have_xpath(xpath)
    end
  end
end






### Links #####################################################

Then /^I should (not |)see a link to (.*?) in the (.*)$/ do |see_or_not, link_target, section_name|
  link_path = path_to(link_target)
  # this is so that if your link_text has ', xpath will still work
  xpath = ".//a[@href=\"#{link_path}\"]"

  within(:xpath, xpath_of_section(section_name)) do
    if see_or_not.blank?
      page.should have_xpath(xpath)
    else
      page.should_not have_xpath(xpath)
    end
  end
end

Then /^I should see a link called "([^\"]*)" linking to (.*?) in the (.*)$/ do |link_text, link_target, section_name|
  link_path = path_to(link_target)
  # this is so that if your link_text has ', xpath will still work
  xpath = ".//a[@href=\"#{link_path}\"][text()=\"#{link_text}\"]"

  within(:xpath, xpath_of_section(section_name)) do
    page.should have_xpath(xpath)
  end
end

Then /^I should (not |)see a link called "([^\"]*)" in the (.*)$/ do |see_or_not, link_text, section_name|
  within(:xpath, xpath_of_section(section_name)) do
    inner_xpath = ".//a[text()='#{link_text}']"
    if see_or_not.blank?
      page.should have_xpath(inner_xpath)
    else
      page.should_not have_xpath(inner_xpath)
    end
  end
end 
# When /^(?:|I )follow "([^"]*)"(?: within "([^"]*)")?$/ do |link, selector|
#   with_scope(selector) do
#     click_link(link)
#   end
# end

When /^(?:|I )follow "([^\"]*)"(?: in the (.*))?$/ do |link_text, section_name|
  unless section_name.blank?
    within(:xpath, xpath_of_section(section_name)) do
      click_link(link_text)
    end
  else
    click_link(link_text)
  end
end

### End Links ###############################################





### Form stuff ##############################################

Then /^"([^\"]*)" should be selected for "([^\"]*)"$/ do |value, field|
  field_labeled(field).find(:xpath, ".//option[@selected = 'selected']").text.should =~ /#{value}/
end

### End form stuff ##########################################
