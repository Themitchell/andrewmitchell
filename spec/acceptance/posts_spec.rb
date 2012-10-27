require File.expand_path(File.dirname(__FILE__) + '../../support/acceptance_helper')

feature "Blog Pages", %q{
  In order to see the most relevant posts
  As a reader
  I want the 5 most recent posts on the front page
} do

  scenario "no posts" do
    visit root_path
    page.should have_content("There are currently no posts.")
  end

  scenario "1 post" do
    author = FactoryGirl.create(:user, username: 'Andrew Mitchell')
    post = FactoryGirl.create(:post,
      title: "My Post",
      body: "This is my post.",
      published_on: "01-01-2010",
      tag_list: "Apple, Ableton",
      author: author
    )
    visit root_path

    within :xpath, "//ol[contains(@class,'list')]" do    
      within :xpath, "li[1]" do
        page.should have_content("My Post")
        page.should have_content("This is my post.")
        page.should have_content("Andrew Mitchell")
        page.should have_content("1 January, 2010")

        click_link "My Post"
      end
    end

    current_path.should == post_path(post.to_param)

    page.should have_content("My Post")
    page.should have_content("This is my post.")
    page.should have_content("Andrew Mitchell")
    page.should have_content("1 January, 2010")
    page.should have_content("Apple")
    page.should have_content("Ableton")
  end

  scenario "pagination on the posts index" do
    Post.destroy_all
    posts = []
    6.times do |n|
      post = FactoryGirl.create(:post, published_on: 30.days.ago+n.days)
      posts <<  post
    end
    old_post = FactoryGirl.create(:post, published_on: 1.year.ago)

    visit root_path

    posts.each do |post|
      page.should have_content(post.title)
    end
    page.should_not have_content(old_post.title)
  end
end
