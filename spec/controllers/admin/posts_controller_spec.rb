require 'spec_helper'

describe Admin::PostsController do
  before :each do
    @admin = Factory(:user, :role => "admin")
    @post1 = Factory(:post, :title => "Post 1", :author => @admin)
    @post2 = Factory(:post, :title => "Post 2", :author => @admin)
  end
  
  describe 'when not logged in' do
    it 'should not respond to index' do
      get :index
      response.should_not be_success
    end
    
    it 'should not respond to show' do
      get :show, :id => @post1
      response.should_not be_success
    end
    
    it 'should not respond to new' do
      get :new
      response.should_not be_success
    end
    
    it 'should not respond to create' do
      post :create
      response.should_not be_success
    end
    
    it 'should not respond to edit' do
      get :edit, :id => @post1
      response.should_not be_success
    end
    
    it 'should not respond to update' do
      post :update, :id => @post1
      response.should_not be_success
    end
    
    it 'should not respond to delete' do
      delete :destroy, :id => @post1
      response.should_not be_success
    end
  end
  
  
  describe 'when logged in' do
    before :each do
      sign_in @admin
    end
  
    describe "GET 'index'" do 
      it "should respond" do
        get :index
        response.should be_success
      end
       
      it 'should get all of the posts ordered by published_on date' do
        get :index
        assigns[:posts].should == [@post2, @post1]
      end
    end
  
    describe "GET 'show'" do
      it "should respond" do
        get :show, :id => @post1
        response.should be_success
      end
      
      it 'should get the correct post' do
        get :show, :id => @post1
        assigns[:post].should == @post1
      end
    end

    describe "GET 'new'" do
      it "should respond" do
        get :new
        response.should be_success
      end
      
      it 'should instantiate a new post' do
        get :new
        assigns[:post].should_not be_nil
      end
    end

    describe "POST 'create'" do
      it "should respond" do
        post :create
        response.should be_success
      end
      
      it 'should allow creation of a valid post' do
        params = {:post => {:title => "A post", :body => "body", :published_on => "01-01-2010", :author => @admin}}
        post :create, params
        post = Post.find_by_title("A post")
        post.should_not be_nil
      end
    
      it 'should not allow creation of a post with invalid params' do
        params = {:post => {:title => "", :body => "body", :published_on => "01-01-2010",  :author => @admin}}
        post :create, params
        post = Post.find_by_body("body")
        post.should be_nil
      end
    end
  
    describe "GET 'edit'" do
      it "should respond" do
        get :edit, :id => @post1
        response.should be_success
      end
      
      it 'should get the correct post' do
        get :edit, :id => @post1.id
        assigns[:post].should == @post1
      end
    end
  
    describe "POST 'update'" do
      it "should respond" do
        get :show, :id => @post1
        response.should be_success
      end
      
      it 'should get the correct post' do
        put :update, :id => @post1
        assigns[:post].should == @post1
      end
    
      it 'should allow updating of a valid post' do
        params = {:id => @post1, :post => {:title => "Updated post", :body => "updated body", :published_on => "01-01-2010", :author => @admin}}
        put :update, params
        post = Post.find_by_title("Updated post")
        post.should_not be_nil
      end
    
      it 'should not allow creation of a post with invalid params' do
        params = {:id => @post1.id, :post => {:title => "", :body => "updated body", :published_on => "01-01-2010",  :author => @admin}}
        post :update, params
        post = Post.find_by_body("updated body")
        post.should be_nil
      end
    end
  
    describe "DELETE 'destroy'" do
      it 'should delete the correct post' do
        post = Factory(:post, :title => "delete me")
        delete :destroy, :id => post.id
        no_post = Post.find_by_title("delete me")
        no_post.should be_nil
      end
    end
  end
end