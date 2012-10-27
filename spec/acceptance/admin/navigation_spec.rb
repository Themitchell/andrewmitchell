require File.expand_path(File.dirname(__FILE__) + '../../../support/acceptance_helper')

feature "Admin Navigation", %q{
  In order to navigate
  As an admin
  I want have a good admin nav bar
} do

  let(:admin) { FactoryGirl.create(:admin) }
  background { login_as(admin) }

  scenario "navigating to the blog page" do
    visit admin_root_path
    click_link "Posts"
    current_path.should == admin_posts_path
  end

  scenario "navigating to the categories page" do
    visit admin_root_path
    click_link "Categories"
    current_path.should == admin_categories_path
  end
  
  scenario "navigating to the photo albums page" do
    visit admin_root_path
    page.should_not have_link "Photo Albums", :href => "/admin/photoalbums"
    # click_link "Photo Albums"
    # current_path.should == photoalbums_path
  end
  
  scenario "navigating to the about page" do
    visit admin_root_path
    page.should_not have_link "About", :href => "/admin/about"
    # click_link "About"
    # current_path.should == about_path
  end
  
  scenario "navigating to the portfolio page" do
    visit admin_root_path
    page.should_not have_link "Portfolio", :href => "/admin/portfolio"
    # click_link "Portfolio"
    # current_path.should == portfolio_path
  end
end
