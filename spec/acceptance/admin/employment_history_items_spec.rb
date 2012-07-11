require File.expand_path(File.dirname(__FILE__) + '../../../support/acceptance_helper')

feature "Admin Posts Pages", %q{
  In order to manage employment_history_items
  As an admin
  I want a employment_history_items admin interface
} do

  background do
    @admin = FactoryGirl.create(:admin)
    login_as(@admin)
  end

  scenario "navigation" do
    employment_history_item = FactoryGirl.create :employment_history_item
    visit admin_employment_history_items_path

    click_link "New Employment history item"
    current_path.should == new_admin_employment_history_item_path
    click_link "Cancel"

    within :xpath, "//table/tr[1]" do
       click_link "Show"
     end
    current_path.should == admin_employment_history_item_path(employment_history_item)
    click_link "Back"

    within :xpath, "//table/tr[1]" do
      click_link "Edit"
    end
    current_path.should == edit_admin_employment_history_item_path(employment_history_item)
    click_link "Cancel"
  end

  scenario "no employment_history_items" do
    visit admin_employment_history_items_path
    current_path.should == admin_employment_history_items_path
    page.should have_content "There are currently no employment history items."
  end

  scenario "Viewing a employment_history_item" do
    employment_history_item = FactoryGirl.create :employment_history_item
    visit admin_employment_history_items_path

    within :xpath, "//table" do
      within :xpath, "tr[1]" do
        page.should have_content employment_history_item.id
        page.should have_content employment_history_item.created_at
        page.should have_content employment_history_item.updated_at
        page.should have_content employment_history_item.company_name
        page.should have_content employment_history_item.company_role
        page.should have_content employment_history_item.role_description
        page.should have_content employment_history_item.date_from
        page.should have_content employment_history_item.date_to
        page.should have_content employment_history_item.location
        click_link "Show"
      end
    end

    current_path.should == admin_employment_history_item_path(employment_history_item)
  end

  scenario "Creating a employment_history_item" do
    visit new_admin_employment_history_item_path

    fill_in "Company name", :with => "Company name dummy content"
    fill_in "Company role", :with => "Company role dummy content"
    fill_in "Role description", :with => "Role description dummy content"
    fill_in "Date from", :with => "02-03-2004"
    fill_in "Date to", :with => "02-03-2004"
    fill_in "Location", :with => "Location dummy content"
    click_button "Save"

    current_path.should == admin_employment_history_item_path(EmploymentHistoryItem.last)
  end

  scenario "Editing a employment_history_item" do
    employment_history_item = FactoryGirl.create :employment_history_item
    visit edit_admin_employment_history_item_path(employment_history_item)

    fill_in "Company name", :with => "Company name dummy content updated"
    fill_in "Company role", :with => "Company role dummy content updated"
    fill_in "Role description", :with => "Role description dummy content updated"
    fill_in "Date from", :with => "03-04-2005"
    fill_in "Date to", :with => "03-04-2005"
    fill_in "Location", :with => "Location dummy content updated"
    click_button "Save"

    current_path.should == admin_employment_history_item_path(employment_history_item)
  end

  scenario "pagination on the employment_history_items index" do
    Post.destroy_all
    employment_history_items = []
    20.times do |n|
      employment_history_item = FactoryGirl.create :employment_history_item, :created_at => 30.days.ago+n.days
      employment_history_items << employment_history_item
    end
    old_employment_history_item = FactoryGirl.create :employment_history_item, :company_role => "another company role", :created_at => 1.year.ago

    visit admin_employment_history_items_path

    employment_history_items.each do |employment_history_item|
      page.should have_content employment_history_item.display_name
    end
    page.should_not have_content old_employment_history_item.company_role
  end
end
