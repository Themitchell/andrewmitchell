require 'spec_helper'

describe PicturesController do
  before :each do
    @picture1 = Factory(:picture, :title => "Picture 1")
    @picture2 = Factory(:picture, :title => "Picture 2")
    @comment1 = Factory(:comment, :commentable => @picture1, :body => "Comment 1")
    @comment2 = Factory(:comment, :commentable => @picture1, :body => "Comment 2")
  end
  
  describe "GET 'index'" do 
    it 'should get all of the pictures ordered by published_on date' do
      get :index
      assigns[:pictures].should == [@picture2, @picture1]
    end
  end
  
  describe "GET 'show'" do
    it "should be successful" do
      get :show, :id => @picture1
      response.should be_success
    end
    
    it 'should get the correct picture' do
      get :show, :id => @picture1
      assigns[:picture].should == @picture1
    end
    
    it 'should get the comments for a picture ordered by created_at date' do
      get :show, :id => @picture1
      assigns[:picture].comments.should == [@comment2, @comment1]
    end
  end
end