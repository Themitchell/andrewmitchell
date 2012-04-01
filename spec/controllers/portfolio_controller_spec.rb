require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe PortfolioController do

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end
    
    it "should assign @portfolio_items with all portfolio items ordered by published on date" do
      pi1 = FactoryGirl.create(:portfolio_item, published_on: 2.days.ago)
      pi2 = FactoryGirl.create(:portfolio_item, published_on: Time.now)
      pi3 = FactoryGirl.create(:portfolio_item, published_on: 2.hours.ago)
      
      get :index
      assigns[:portfolio_items].should == [pi2, pi3, pi1]
    end
  end

  # describe "GET 'show'" do
  #   it "returns http success" do
  #     get :show
  #     response.should be_success
  #   end
  # end

end
