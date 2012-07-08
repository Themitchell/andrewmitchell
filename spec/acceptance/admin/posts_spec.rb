require File.expand_path(File.dirname(__FILE__) + '../../../support/acceptance_helper')

feature "Admin Posts Pages", %q{
  In order to manage posts
  As an admin
  I want a posts admin interface
} do

  background do
    @category = FactoryGirl.create(:category)
    @admin = FactoryGirl.create(:admin)
    login_as(@admin)
  end

  scenario "navigation" do
    post = FactoryGirl.create(:post)
    visit admin_posts_path

    click_link "New Post"
    current_path.should == new_admin_post_path
    click_link "Posts"

    within :xpath, "//table/tr[1]" do
       click_link "Show"
     end
    current_path.should == admin_post_path(post)
    click_link "Back"

    within :xpath, "//table/tr[1]" do
      click_link "Edit"
    end
    current_path.should == edit_admin_post_path(post)
  end

  scenario "no posts" do
    visit admin_posts_path
    current_path.should == admin_posts_path
    page.should have_content "There are currently no posts."
  end

  scenario "Viewing a post" do
    post = FactoryGirl.create :post
    visit admin_posts_path

    within :xpath, "//table" do
      within :xpath, "tr[1]" do
        page.should have_content post.title
        page.should have_content post.author.login
        page.should have_content post.created_at
        page.should have_content post.published_on

        click_link "Show"
      end
    end

    current_path.should == admin_post_path(post)
  end

  scenario "Creating a post" do
    visit admin_posts_path
    click_link "New Post"
    fill_in("Title", :with => "My Post")
    fill_in("Body", :with => "This is my post.")
    fill_in("Category", :with => @category.id)
    fill_in("Published on", :with => "01/01/2010")
    click_button "Save"

    current_path.should == admin_post_path(Post.find_by_title("My Post"))
    page.should have_content ""
  end

  scenario "Editing a post" do
    post = FactoryGirl.create(:post)
    visit edit_admin_post_path(post)

    fill_in("Title", :with => "My Post Updated")
    fill_in("Body", :with => "This is my post updated.")
    fill_in("Category", :with => @category.id)
    fill_in("Published on", :with => "01/02/2010")
    click_button "Save"

    current_path.should == admin_post_path(post)
  end

  scenario "pagination on the posts index" do
    Post.destroy_all
    posts = []
    6.times do |n|
      post = FactoryGirl.create :post, published_on: 30.days.ago+n.days
      posts <<  post
    end
    old_post = FactoryGirl.create :post, published_on: 1.year.ago

    visit posts_path

    posts.each do |post|
      page.should have_content post.title
    end
    page.should_not have_content old_post.title
  end
end
