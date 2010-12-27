# == Schema Information
#
# Table name: posts
#
#  id           :integer(4)      not null, primary key
#  title        :string(255)
#  body         :text
#  author_id    :integer(4)
#  published_on :date
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Post do
  
  describe 'validations' do
    it 'should be invalid without a title' do
      p = Factory.build(:post, :title => nil)
      p.should_not be_valid
      p.errors[:title].should_not be_empty
    end
    
    it 'should be invalid with a title as an empty string' do
      p = Factory.build(:post, :title => "")
      p.should_not be_valid
      p.errors[:title].should_not be_empty
    end
    
    it 'should be invalid without a body' do
      p = Factory.build(:post, :body => nil)
      p.should_not be_valid
      p.errors[:body].should_not be_empty
    end
    
    it 'should be invalid with a body as an empty string' do
      p = Factory.build(:post, :body => "")
      p.should_not be_valid
      p.errors[:body].should_not be_empty
    end
    
    it 'should be invalid without an author' do
      p = Factory.build(:post, :author => nil)
      p.should_not be_valid
      p.errors[:author].should_not be_empty
    end
    
    it 'should be invalid without a published on date' do
      p = Factory.build(:post, :published_on => nil)
      p.should_not be_valid
      p.errors[:published_on].should_not be_empty
    end
    
    it 'should be invalid with a published on date as an empty string' do
      p = Factory.build(:post, :published_on => "")
      p.should_not be_valid
      p.errors[:published_on].should_not be_empty
    end
    
    it 'should be valid with a tag list' do
      p = Factory.build(:post, :tag_list => "Apple, iPod")
      p.should be_valid
      p.errors[:tag_list].should be_empty
    end
    
    it 'should be valid without a tag list' do
      p = Factory.build(:post, :tag_list => nil)
      p.should be_valid
      p.errors[:tag_list].should be_empty
    end
  end
  
  describe 'associations' do
    it "should belong to user" do
      user = Factory.create(:user)
      post = Factory.create(:post, :author => user)
      post.author.should == user
    end
  end
end
