require File.expand_path(File.dirname(__FILE__) + '../../../support/acceptance_helper')

feature "Admin Posts Pages", %q{
  In order to manage educational_qualifications
  As an admin
  I want a educational_qualifications admin interface
} do

  background do
    @admin = FactoryGirl.create(:admin)
    login_as(@admin)
  end

  scenario "navigation" do
    educational_qualification = FactoryGirl.create :educational_qualification
    visit admin_educational_qualifications_path

    click_link "New Educational qualification"
    current_path.should == new_admin_educational_qualification_path
    click_link "Cancel"

    within :xpath, "//table/tr[1]" do
       click_link "Show"
     end
    current_path.should == admin_educational_qualification_path(educational_qualification)
    click_link "Back"

    within :xpath, "//table/tr[1]" do
      click_link "Edit"
    end
    current_path.should == edit_admin_educational_qualification_path(educational_qualification)
    click_link "Cancel"
  end

  scenario "no educational_qualifications" do
    visit admin_educational_qualifications_path
    current_path.should == admin_educational_qualifications_path
    page.should have_content "There are currently no educational qualifications."
  end

  scenario "Viewing a educational_qualification" do
    educational_qualification = FactoryGirl.create :educational_qualification
    visit admin_educational_qualifications_path

    within :xpath, "//table" do
      within :xpath, "tr[1]" do
        page.should have_content educational_qualification.id
        page.should have_content educational_qualification.created_at
        page.should have_content educational_qualification.updated_at
        page.should have_content educational_qualification.name
        page.should have_content educational_qualification.institution
        page.should have_content educational_qualification.grade
        page.should have_content educational_qualification.date_from
        page.should have_content educational_qualification.date_to
        click_link "Show"
      end
    end

    current_path.should == admin_educational_qualification_path(educational_qualification)
  end

  scenario "Creating a educational_qualification" do
    visit new_admin_educational_qualification_path

    fill_in "Name", :with => "Name dummy content"
    fill_in "Institution", :with => "Institution dummy content"
    fill_in "Grade", :with => "Grade dummy content"
    fill_in "Date from", :with => "02-03-2004"
    fill_in "Date to", :with => "02-03-2004"
    click_button "Save"

    current_path.should == admin_educational_qualification_path(EducationalQualification.last)
  end

  scenario "Editing a educational_qualification" do
    educational_qualification = FactoryGirl.create :educational_qualification
    visit edit_admin_educational_qualification_path(educational_qualification)

    fill_in "Name", :with => "Name dummy content updated"
    fill_in "Institution", :with => "Institution dummy content updated"
    fill_in "Grade", :with => "Grade dummy content updated"
    fill_in "Date from", :with => "03-04-2005"
    fill_in "Date to", :with => "03-04-2005"
    click_button "Save"

    current_path.should == admin_educational_qualification_path(educational_qualification)
  end

  scenario "pagination on the educational_qualifications index" do
    Post.destroy_all
    educational_qualifications = []
    20.times do |n|
      educational_qualification = FactoryGirl.create :educational_qualification, :created_at => 30.days.ago+n.days
      educational_qualifications << educational_qualification
    end
    old_educational_qualification = FactoryGirl.create :educational_qualification, :name => "Something random", :created_at => 1.year.ago

    visit admin_educational_qualifications_path

    educational_qualifications.each do |educational_qualification|
      page.should have_content educational_qualification.display_name
    end
    page.should_not have_content old_educational_qualification.display_name
  end
end
