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

  scenario "categories index" do
    visit root_path

    within :xpath, "//aside[@id='categories']/ul" do      
      page.should have_xpath( "li[1][contains(@class, '#{@cat2.permalink}')]/a[@href='#{posts_category_path(@cat2)}']",
                              :text => @cat2.name.titleize)
      within :xpath, "li[2][contains(@class, '#{@cat1.permalink}')]" do
        click_link @cat1.name.titleize
      end
    end
                            
    current_path.should == posts_category_path(@cat1)
    
    within :xpath, "//div[@id='posts_page']" do
      page.should have_xpath("//article[@class='post_mini']/h3/a", :text => @post1.title.titleize)
      page.should_not have_xpath("//article[@class='post_mini']/h3/a", :text => @post2.title.titleize)
    end
  end
end