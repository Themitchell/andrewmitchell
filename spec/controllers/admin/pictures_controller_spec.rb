require 'spec_helper'

describe Admin::PicturesController do
  before :each do
    @admin = Factory(:user, :role => "admin")
    @picture1 = Factory(:picture, :title => "Picture 1", :author => @admin)
    @picture2 = Factory(:picture, :title => "Picture 2", :author => @admin)
  end
  
  describe 'when not logged in' do
    it 'should not respond to index' do
      get :index
      response.should_not be_success
    end
    
    it 'should not respond to show' do
      get :show, :id => @picture1
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
      get :edit, :id => @picture1
      response.should_not be_success
    end
    
    it 'should not respond to update' do
      post :update, :id => @picture1
      response.should_not be_success
    end
    
    it 'should not respond to delete' do
      delete :destroy, :id => @picture1
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
       
      it 'should get all of the pictures ordered by published_on date' do
        get :index
        assigns[:pictures].should == [@picture2, @picture1]
      end
    end
  
    describe "GET 'show'" do
      it "should respond" do
        get :show, :id => @picture1
        response.should be_success
      end
      
      it 'should get the correct picture' do
        get :show, :id => @picture1
        assigns[:picture].should == @picture1
      end
    end

    describe "GET 'new'" do
      it "should respond" do
        get :new
        response.should be_success
      end
      
      it 'should instantiate a new picture' do
        get :new
        assigns[:picture].should_not be_nil
      end
    end

    describe "POST 'create'" do
      it "should respond" do
        post :create
        response.should be_success
      end
      
      it 'should allow creation of a valid picture' do
        params = {:picture => {:title => "A picture", :picture => File.open("#{Rails.root}/features/support/images/picture.jpg"), :published_on => "01-01-2010", :author => @admin}}
        post :create, params
        picture = Picture.find_by_title("A picture")
        picture.should_not be_nil
      end
    
      it 'should not allow creation of a picture with invalid params' do
        params = {:picture => {:title => "", :picture => File.open("#{Rails.root}/features/support/images/picture.jpg"), :published_on => "01-01-2010",  :author => @admin}}
        post :create, params
        picture = Picture.find_by_title("")
        picture.should be_nil
      end
    end
  
    describe "GET 'edit'" do
      it "should respond" do
        get :edit, :id => @picture1
        response.should be_success
      end
      
      it 'should get the correct picture' do
        get :edit, :id => @picture1
        assigns[:picture].should == @picture1
      end
    end
  
    describe "POST 'update'" do
      it "should respond" do
        get :show, :id => @picture1
        response.should be_success
      end
      
      it 'should get the correct picture' do
        put :update, :id => @picture1
        assigns[:picture].should == @picture1
      end
    
      it 'should allow updating of a valid picture' do
        params = {:id => @picture1, :picture => {:title => "Updated picture", :picture => File.open("#{Rails.root}/features/support/images/picture.jpg"), :published_on => "01-01-2010", :author => @admin}}
        put :update, params
        picture = Picture.find_by_title("Updated picture")
        picture.should_not be_nil
      end
    
      it 'should not allow creation of a picture with invalid params' do
        params = {:id => @picture1, :picture => {:title => "", :picture => File.open("#{Rails.root}/features/support/images/picture.jpg"), :published_on => "01-01-2010",  :author => @admin}}
        put :update, params
        picture = Picture.find_by_title("")
        picture.should be_nil
      end
    end
  
    describe "DELETE 'destroy'" do
      it 'should delete the correct picture' do
        picture = Factory(:picture, :title => "delete me")
        delete :destroy, :id => picture
        no_picture = Picture.find_by_title("delete me")
        no_picture.should be_nil
      end
    end
  end
end