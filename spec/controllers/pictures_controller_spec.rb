require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe PicturesController do
  before :each do
    @photoalbum = FactoryGirl.create(:photoalbum, :name => "My photoalbum")
    @picture1 = FactoryGirl.create(:picture, photoalbum: @photoalbum, title: "Picture 1")
    @picture2 = FactoryGirl.create(:picture, photoalbum: @photoalbum, title: "Picture 2")
    @comment1 = FactoryGirl.create(:comment, commentable: @picture1, body: "Comment 1")
    @comment2 = FactoryGirl.create(:comment, commentable: @picture1, body: "Comment 2")
  end
  
  describe "GET 'show'" do
    it "should be successful" do
      get :show, :photoalbum_id => @photoalbum.to_param, :id => @picture1.to_param
      response.should be_success
    end
    
    it 'should get the correct picture' do
      get :show, :photoalbum_id => @photoalbum.to_param, :id => @picture1.to_param
      assigns[:picture].should == @picture1
    end
    
    it 'should get the comments for a picture ordered by created_at date' do
      get :show, :photoalbum_id => @photoalbum.to_param, :id => @picture1.to_param
      assigns[:picture].comments.should == [@comment2, @comment1]
    end
  end
end