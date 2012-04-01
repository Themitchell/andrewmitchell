require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe CommentsController do
  describe "find_commentable" do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    
    it "should find the name of the first parameter in the hash" do
      post = FactoryGirl.create(:post)      
      get :new, :post_id => post.to_param
      assigns[:commentable].should == post
    end
    
    it "should find the second parameter if the resource is nested within photoalbums" do
      photoalbum = FactoryGirl.create(:photoalbum)
      picture = FactoryGirl.create(:picture, :photoalbum => photoalbum)
      get :new, :photoalbum_id => photoalbum.to_param, :picture_id => picture.to_param
      assigns[:commentable].should == picture
    end
  end
end