require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe AboutController do
  before :each do
    @cat1 = FactoryGirl.create(:category, name: 'news')
    @cat2 = FactoryGirl.create(:category, name: 'audio')
  end
  
  describe "GET 'index'" do 
    it 'should get the personal statement content block' do
      cb = FactoryGirl.create(:content_block, name: "personal statement")
      get :index
      assigns[:personal_statement].should == cb
    end

    it "should assign @categories with all categories sorted by name" do
      get :index
      assigns[:categories].should == [@cat2, @cat1]
    end
  end
  
  describe "GET 'employment_history'" do
    it 'should get the employment history ordered by end date nil first then start date' do
      @eh_item_2 = FactoryGirl.create(:employment_history_item, date_from: 3.years.ago.to_date, date_to: nil)
      @eh_item_3 = FactoryGirl.create(:employment_history_item, date_from: 2.years.ago.to_date, date_to: 1.year.ago.to_date)
      @eh_item_1 = FactoryGirl.create(:employment_history_item, date_from: 1.year.ago.to_date,  date_to: nil)
      @eh_item_4 = FactoryGirl.create(:employment_history_item, date_from: 4.years.ago.to_date, date_to: 1.year.ago.to_date)
      
      get :employment_history
      assigns[:employment_history].should == [@eh_item_1, @eh_item_2, @eh_item_3, @eh_item_4]
    end
    
    it "should assign @categories with all categories sorted by name" do
      get :employment_history
      assigns[:categories].should == [@cat2, @cat1]
    end
  end
  
  describe "GET 'educational_qualifications'" do
    it 'should get all the educational qualifications ordered by end date nil first then start date' do
      @eq2 = FactoryGirl.create(:educational_qualification, date_from: 3.years.ago.to_date, date_to: nil)
      @eq3 = FactoryGirl.create(:educational_qualification, date_from: 2.years.ago.to_date, date_to: 1.year.ago.to_date)
      @eq1 = FactoryGirl.create(:educational_qualification, date_from: 1.year.ago.to_date,  date_to: nil)
      @eq4 = FactoryGirl.create(:educational_qualification, date_from: 4.years.ago.to_date, date_to: 1.year.ago.to_date)
      
      get :educational_qualifications
      assigns[:educational_qualifications].should == [@eq1, @eq2, @eq3, @eq4]
    end
    
    it "should assign @categories with all categories sorted by name" do
      get :educational_qualifications
      assigns[:categories].should == [@cat2, @cat1]
    end
  end
end
