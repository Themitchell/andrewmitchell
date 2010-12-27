# == Schema Information
#
# Table name: pictures
#
#  id                   :integer(4)      not null, primary key
#  title                :string(255)
#  description          :text
#  author_id            :integer(4)
#  published_on         :date
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer(4)
#  created_at           :datetime
#  updated_at           :datetime
#

require 'spec_helper'

describe Comment do
  
  describe 'validations' do
    it 'should be invalid without a body' do
      c = Factory.build(:comment, :body => nil)
      c.should_not be_valid
      c.errors[:body].should_not be_empty
    end
    
    it 'should be invalid with a title as an empty string' do
      c = Factory.build(:comment, :body => "")
      c.should_not be_valid
      c.errors[:body].should_not be_empty
    end
  end
  
  describe 'associations' do
    it "should belong to user" do
      user = Factory.create(:user)
      c = Factory.create(:comment, :author => user)
      c.author.should == user
    end
    
    it 'should belong to a commentable' do
      user = Factory.create(:user)
      post = Factory.create(:post, :author => user)
      c = Factory.create(:comment, :commentable => post)
      c.commentable.should == post
    end
  end
end
