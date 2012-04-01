require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe ApplicationHelper do
  describe "published_on_text" do
    it "should return the published on text for a given object" do
      p = FactoryGirl.create(:post, published_on: "15-10-2000")
      published_on_text(p).should == "15 October, 2000"
    end
  end
  
  describe "comment_published_on_text" do
    it "should return the comments published on text" do
      c = FactoryGirl.create(:comment, created_at: "15-10-2000")
      comment_published_on_text(c).should == "15 October, 2000"
    end
  end
  
  describe "commentable_path" do
    it "should return the url for the commentable" do
      p = FactoryGirl.create(:post, title: "A Post")
      commentable_path(p).should == "/posts/a-post"
    end
    
    it "should return the url for the commentable if it is a nested resource" do
      pa = FactoryGirl.create(:photoalbum, name: "A photoalbum")
      p = FactoryGirl.create(:picture, title: "A Picture", photoalbum: pa)
      commentable_path(p).should == "/photoalbums/a-photoalbum/pictures/a-picture"
    end
  end
end