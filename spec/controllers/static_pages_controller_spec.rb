require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe StaticPagesController do
  before :each do
    @cat1 = FactoryGirl.create(:category, name: 'news')
    @cat2 = FactoryGirl.create(:category, name: 'audio')
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get :contact
      response.should be_success
    end
    
    it "should assign @categories with all categories sorted by name" do
      get :contact
      assigns[:categories].should == [@cat2, @cat1]
    end
  end
end
