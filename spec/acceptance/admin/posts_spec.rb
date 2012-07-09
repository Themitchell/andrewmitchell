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
    post = FactoryGirl.create :post
    visit admin_posts_path

    click_link "New Post"
    current_path.should == new_admin_post_path
    click_link "Cancel"

    within :xpath, "//table/tr[1]" do
       click_link "Show"
     end
    current_path.should == admin_post_path(post)
    click_link "Back"

    within :xpath, "//table/tr[1]" do
      click_link "Edit"
    end
    current_path.should == edit_admin_post_path(post)
    click_link "Cancel"
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
        page.should have_content post.id
        page.should have_content post.author_id
        page.should have_content post.created_at
        page.should have_content post.updated_at
        page.should have_content post.permalink
        page.should have_content post.title
        page.should have_content post.body
        page.should have_content post.published_on
        page.should have_content post.category.display_name
        click_link "Show"
      end
    end

    current_path.should == admin_post_path(post)
  end

  scenario "Creating a post" do
    visit new_admin_post_path

    fill_in "Title", :with => "Title dummy content"
    fill_in "Body", :with => "Body dummy content"
    fill_in "Published on", :with => "02-03-2004"
    select @category.display_name, :from => "Category"
    click_button "Save"

    current_path.should == admin_post_path(Post.last)
  end

  scenario "Editing a post" do
    post = FactoryGirl.create :post
    visit edit_admin_post_path(post)

    fill_in "Title", :with => "Title dummy content updated"
    fill_in "Body", :with => "Body dummy content updated"
    fill_in "Published on", :with => "03-04-2005"
    select @category.display_name, :from => "Category"
    click_button "Save"

    current_path.should == admin_post_path(post)
  end

  scenario "pagination on the posts index" do
    Post.destroy_all
    posts = []
    20.times do |n|
      post = FactoryGirl.create :post, :created_at => 30.days.ago+n.days
      posts <<  post
    end
    old_post = FactoryGirl.create :post, :created_at => 1.year.ago

    visit admin_posts_path

    posts.each do |post|
      page.should have_content post.display_name
    end
    page.should_not have_content old_post.display_name
  end
end
