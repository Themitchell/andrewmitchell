require File.expand_path(File.dirname(__FILE__) + '../../../support/acceptance_helper')

feature "Admin Posts Pages", %q{
  In order to manage categories
  As an admin
  I want a categories admin interface
} do

  let(:admin) { FactoryGirl.create(:admin) }
  background { login_as(admin) }

  scenario "navigation" do
    category = FactoryGirl.create :category
    visit admin_categories_path

    click_link "New Category"
    current_path.should == new_admin_category_path
    click_link "Cancel"

    within :xpath, "//table/tr[1]" do
       click_link "Show"
     end
    current_path.should == admin_category_path(category)
    click_link "Back"

    within :xpath, "//table/tr[1]" do
      click_link "Edit"
    end
    current_path.should == edit_admin_category_path(category)
    click_link "Cancel"
  end

  scenario "no categories" do
    visit admin_categories_path
    current_path.should == admin_categories_path
    page.should have_content "There are currently no categories."
  end

  scenario "Viewing a category index" do
    category = FactoryGirl.create :category
    visit admin_categories_path

    within :xpath, "//table" do
      within :xpath, "tr[1]" do
        page.should have_content category.id
        page.should have_content category.author.username
        page.should have_content category.created_at
        page.should have_content category.name
        click_link "Show"
      end
    end

    current_path.should == admin_category_path(category)
  end

  scenario "Creating a category" do
    visit new_admin_category_path

    fill_in "Name", :with => "Name dummy content"
    click_button "Save"

    current_path.should == admin_category_path(Category.last)

    page.should have_content admin.username
    page.should have_content "Name dummy content"
    page.should have_content "name-dummy-content"
  end

  scenario "Editing a category" do
    category = FactoryGirl.create :category
    visit edit_admin_category_path(category)

    fill_in "Name", :with => "Name dummy content updated"
    click_button "Save"

    category.reload

    current_path.should == admin_category_path(category)

    page.should have_content admin.username
    page.should have_content "Name dummy content updated"
    page.should have_content "name-dummy-content-updated"
  end

  scenario "pagination on the categories index" do
    Post.destroy_all
    categories = []
    20.times do |n|
      category = FactoryGirl.create :category, :created_at => 30.days.ago+n.days
      categories << category
    end
    old_category = FactoryGirl.create :category, :created_at => 1.year.ago

    visit admin_categories_path

    categories.each do |category|
      page.should have_content category.display_name
    end
    page.should_not have_content old_category.display_name
  end
end
