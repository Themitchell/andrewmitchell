require File.expand_path(File.dirname(__FILE__) + '../../support/acceptance_helper')

feature "Categories", %q{
  In order to narrow down my post search
  As an user
  I want to view a list of category links to filter the blog
} do

  background do
    @cat1 = FactoryGirl.create(:category, name: "news")
    @cat2 = FactoryGirl.create(:category, name: "audio")
    
    @post1 = FactoryGirl.create(:post, category: @cat1)
    @post2 = FactoryGirl.create(:post, category: @cat2)
  end

  scenario "posts index ordered alphabetically" do
    visit posts_path

    within :xpath, "//nav[@id='category_nav']/ul" do
      page.should have_xpath( "li[1]/a[@href='#{posts_category_path(@cat2)}']", :text => @cat2.name)
      within :xpath, "li[2]" do
        click_link @cat1.name
      end
    end
                            
    current_path.should == posts_category_path(@cat1)
    
    page.should have_xpath("//article[@class='post_mini']/h2/a", :text => @post1.title)
    page.should_not have_xpath("//article[@class='post_mini']/h2/a", :text => @post2.title)
  end
end
