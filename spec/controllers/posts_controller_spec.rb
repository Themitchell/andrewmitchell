require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe PostsController do
  before :each do
    @cat1 = FactoryGirl.create(:category, name: 'news')
    @cat2 = FactoryGirl.create(:category, name: 'audio')
    
    @post1 = FactoryGirl.create(:post, title: "Post 1", category: @cat1)
    @post2 = FactoryGirl.create(:post, title: "Post 2", category: @cat2)
    @comment1 = FactoryGirl.create(:comment, commentable: @post1)
    @comment2 = FactoryGirl.create(:comment, commentable: @post1)
  end
  
  describe "GET 'index'" do 
    it 'should get all of the posts ordered by published_on date' do
      get :index
      assigns[:posts].should == [@post2, @post1]
    end
    
    it "should assign @categories with all categories sorted by name" do
      get :index, :controller => :posts
      assigns[:categories].should == [@cat2, @cat1]
    end
  end
  
  describe "GET 'show'" do
    it "should be successful" do
      get :show, :id => @post1.to_param
      response.should be_success
    end
    
    it 'should get the correct post' do
      get :show, :id => @post1.to_param
      assigns[:post].should == @post1
    end
    
    it 'should get the comments for a post ordered by created_at date' do
      get :show, :id => @post1.to_param
      assigns[:post].comments.should == [@comment2, @comment1]
    end
    
    it "should assign @categories with all categories sorted by name" do
      get :index, :controller => :posts
      assigns[:categories].should == [@cat2, @cat1]
    end 
  end
  
  describe "GET 'category'" do
    it "should render the index template" do
      get :category, :category_permalink => @cat1.to_param
      response.should render_template('index')
    end
    it 'should assign the category' do
      get :category, :category_permalink => @cat1.to_param
      assigns[:category].should == @cat1
    end
    
    it 'should get all of the posts ordered by published_on date for that category' do
      get :category, :category_permalink => @cat1.to_param
      assigns[:posts].should == [@post1]
    end
    
    it "should assign @categories with all categories sorted by name" do
      get :category, :category_permalink => @cat1.to_param
      assigns[:categories].should == [@cat2, @cat1]
    end
  end
end