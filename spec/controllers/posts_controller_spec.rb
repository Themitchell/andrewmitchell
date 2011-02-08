require 'spec_helper'

describe PostsController do
  before :each do
    @post1 = Factory(:post, :title => "Post 1")
    @post2 = Factory(:post, :title => "Post 2")
    @comment1 = Factory(:comment, :commentable => @post1)
    @comment2 = Factory(:comment, :commentable => @post1)
  end
  
  describe "GET 'index'" do 
    it 'should get all of the posts ordered by published_on date' do
      get :index
      assigns[:posts].should == [@post2, @post1]
    end
  end
  
  describe "GET 'show'" do
    it "should be successful" do
      get :show, :id => @post1
      response.should be_success
    end
    
    it 'should get the correct post' do
      get :show, :id => @post1
      assigns[:post].should == @post1
    end
    
    it 'should get the comments for a post ordered by created_at date' do
      get :show, :id => @post1
      assigns[:post].comments.should == [@comment2, @comment1]
    end 
  end
end