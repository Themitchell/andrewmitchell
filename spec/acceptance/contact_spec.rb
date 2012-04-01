require File.expand_path(File.dirname(__FILE__) + '../../support/acceptance_helper')

feature "Contact Page", %q{
  In order to contact me
  As an user
  I want to view a my contact details
} do

  background do
  end

  scenario "viewing the contact page" do
    
    visit contact_path
    page.should have_xpath("//h2", :text => "Contact")
    page.should have_xpath("//section[@class='vcard']")
  end
end