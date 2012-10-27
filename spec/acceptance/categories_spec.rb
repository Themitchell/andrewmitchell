require File.expand_path(File.dirname(__FILE__) + '../../support/acceptance_helper')

feature "Categories", %q{
  In order to narrow down my post search
  As an user
  I want to view a list of category links to filter the blog
} do

  let!(:cat1) { FactoryGirl.create :category, name: "news" }
  let!(:cat2) { FactoryGirl.create :category, name: "audio" }

  scenario "posts index ordered alphabetically" do
    post1 = FactoryGirl.create :post, category: cat1
    post2 = FactoryGirl.create :post, category: cat2

    visit root_path

    within "nav#category_nav ul" do
      page.should have_link "audio", :href => posts_category_path(cat2)

      within :xpath, "li[2]" do
        click_link "news"
      end
    end
                            
    current_path.should == posts_category_path(cat1)
    
    page.should have_link post1.title
    page.should_not have_link post2.title
  end
end
