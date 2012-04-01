require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe PhotoalbumsController do
  before :each do
    @pa1 = FactoryGirl.create(:photoalbum, name: "Photoalbum 1")
    @pa2 = FactoryGirl.create(:photoalbum, name: "Photoalbum 2")
    @picture1 = FactoryGirl.create(:picture, photoalbum: @pa1)
    @picture2 = FactoryGirl.create(:picture, photoalbum: @pa1)
  end
  
  describe "GET 'index'" do
    it 'should get all of the photoalbums ordered by published_on date' do
      get :index
      assigns[:photoalbums].should == [@pa2, @pa1]
    end
  end
  
  describe "GET 'show'" do
    it "should be successful" do
      get :show, :id => @pa1.to_param
      response.should be_success
    end
    
    it 'should get the correct photoalbum' do
      get :show, :id => @pa1.to_param
      assigns[:photoalbum].should == @pa1
    end
    
    it "should get all of the pictures related to a photoalbum" do
      get :show, :id => @pa1.to_param
      assigns[:photoalbum].pictures.count.should == 2
    end
  end
end