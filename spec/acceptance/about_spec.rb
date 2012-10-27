require File.expand_path(File.dirname(__FILE__) + '../../support/acceptance_helper')

feature "About Page", %q{
  In order to read all about me
  As an user
  I want to view a personal profile including my cv
} do

  scenario "viewing the about page" do
    @content_block = FactoryGirl.create(:content_block, name: "personal statement", body: "<p>some bunch  of text here</p>")
    
    visit about_path
    
    within :xpath, "//div[@id='about_me']" do      
      page.should have_xpath( 'p', :text => 'some bunch  of text here')
    end
  end
  
  scenario "viewing my employment history" do
    @eh_item_3 = FactoryGirl.create(:employment_history_item, company_name: "Puzzled Records",  date_to: 4.days.ago.to_date)
    @eh_item_2 = FactoryGirl.create(:employment_history_item, company_name: "Jigsore",          date_to: 2.days.ago.to_date)
    @eh_item_1 = FactoryGirl.create(:employment_history_item, company_name: "Unboxed",          date_to: nil, location: "London")
    @eh_item_4 = FactoryGirl.create(:employment_history_item, company_name: "BSS",              date_to: 6.days.ago.to_date)
    
    visit employment_history_path
    
    within "section#employment_history ol" do
      within :xpath, "li[1]" do
        page.should have_css "h2", :text => "Unboxed"
        page.should have_css "h2 span.company_location", :text => @eh_item_1.location
        page.should have_css "h3.role", :text => @eh_item_1.company_role
        page.should have_css "div.role_description", :text => @eh_item_1.role_description
        within "p.time_period" do
          page.should have_css "span.date_from", :text => @eh_item_1.date_from.strftime("%B %Y")
          page.should have_css "span.date_to", :text => "ongoing"
        end
      end
      
      page.should have_xpath("li[2]/h2", :text => "Jigsore")
      page.should have_xpath("li[3]/h2", :text => "Puzzled Records")
      page.should have_xpath("li[4]/h2", :text => "BSS")
    end
  end
  
  scenario "viewing my educational qualifications" do
    @eq3 = FactoryGirl.create(:educational_qualification, name: "Sound",    date_to: 4.days.ago.to_date)
    @eq2 = FactoryGirl.create(:educational_qualification, name: "Physics",  date_to: 2.days.ago.to_date)
    @eq1 = FactoryGirl.create(:educational_qualification, name: "Maths",    date_to: nil, grade: "merit")
    @eq4 = FactoryGirl.create(:educational_qualification, name: "Biology",  date_to: 6.days.ago.to_date)
    
    visit educational_qualifications_path
    
    within "section#educational_qualifications ol" do
      within :xpath, "li[1]" do
        page.should have_css "h2", :text => @eq1.name
        page.should have_css "h2 span.grade", :text => @eq1.grade
        page.should have_css "h3.institution", :text => @eq1.institution
        within "p.time_period" do
          page.should have_css "span.date_from", :text => @eq1.date_from.strftime("%B %Y")
          page.should have_css "span.date_to", :text => "ongoing"
        end        
      end
      
      page.should have_xpath("li[2]/h2", :text => @eq2.name)
      page.should have_xpath("li[3]/h2", :text => @eq3.name)
      page.should have_xpath("li[4]/h2", :text => @eq4.name)
    end
  end
  
  scenario "viewing the about page with some nil values" do
    
    visit about_path
    page.status_code.should == 200
    page.should_not have_css "section#personal_statement"
    
    visit employment_history_path
    page.status_code.should == 200
    page.should_not have_css "section#employment_history"
    
    visit educational_qualifications_path
    page.status_code.should == 200
    page.should_not have_css "section#educational_qualifications"
  end
end
