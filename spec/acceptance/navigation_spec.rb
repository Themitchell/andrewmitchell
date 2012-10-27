require File.expand_path(File.dirname(__FILE__) + '../../support/acceptance_helper')

feature "User Navigation", %q{
  In order to navigate
  As an user
  I want have a good user nav bar
} do

  background do
  end

  scenario "navigating to the blog page" do
    visit root_path
    click_link "Blog"
    current_path.should == root_path
  end

  scenario "navigating to the about page" do
    visit root_path
    click_link "About Me"
    current_path.should == about_path
  end
  
  scenario "navigating to the photo albums page" do
    visit root_path
    page.should_not have_link "Photo Albums", :href => "/photoalbums"
    # click_link "Photo Albums"
    # current_path.should == photoalbums_path
  end
  
  scenario "navigating to the portfolio page" do
    visit root_path
    page.should_not have_link "Portfolio", :href => "/portfolio"
    # click_link "Portfolio"
    # current_path.should == portfolio_path
  end
end
