require File.expand_path(File.dirname(__FILE__) + '../../support/acceptance_helper')

feature "Portfolio Page", %q{
  In order to read all about me
  As an user
  I want to view a portfolio of my work
} do

  background do
    @pi1 = FactoryGirl.create(:portfolio_item)
  end

  scenario "viewing the portfolio page with minimal attributes" do
        
    visit portfolio_path
    
    within :xpath, "//ol[@id='portfolio_items']" do    
      within :xpath, "li" do
        page.should have_xpath( 'h3', :text => @pi1.title )
        page.should have_xpath( 'p', :text => @pi1.description )
      end
    end
  end
end