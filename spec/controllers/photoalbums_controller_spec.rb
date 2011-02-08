require 'spec_helper'

describe PhotoalbumsController do
  before :each do
    @pa1 = Factory(:photoalbum, :name => "Photoalbum 1")
    @pa2 = Factory(:photoalbum, :name => "Photoalbum 2")
    @picture1 = Factory(:picture, :photoalbum => @pa1)
    @picture2 = Factory(:picture, :photoalbum => @pa1)
  end
  
  describe "GET 'index'" do
    it 'should get all of the photoalbums ordered by published_on date' do
      get :index
      assigns[:photoalbums].should == [@pa2, @pa1]
    end
  end
  
  describe "GET 'show'" do
    it "should be successful" do
      get :show, :id => @pa1
      response.should be_success
    end
    
    it 'should get the correct photoalbum' do
      get :show, :id => @pa1
      assigns[:photoalbum].should == @pa1
    end
  end
end