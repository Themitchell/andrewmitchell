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

describe Picture do
  
  describe 'validations' do
    it 'should be invalid without a title' do
      p = Factory.build(:picture, :title => nil)
      p.should_not be_valid
      p.errors[:title].should_not be_empty
    end
    
    it 'should be invalid with a title as an empty string' do
      p = Factory.build(:picture, :title => "")
      p.should_not be_valid
      p.errors[:title].should_not be_empty
    end
    
    it "should be invalid with a title that already exists" do
      Factory.create(:picture, :title => "a photoalbum")
      p = Factory.build(:picture, :title => "a photoalbum")
      p.should_not be_valid
      p.errors[:title].should_not be_empty
    end
    
    it 'should be invalid without a picture' do
      p = Factory.build(:picture)
      p.picture = nil
      p.should_not be_valid
      p.errors[:picture_file_name].should_not be_empty
    end
    
    it 'should be invalid without an author' do
      p = Factory.build(:picture, :author => nil)
      p.should_not be_valid
      p.errors[:author].should_not be_empty
    end
    
    it 'should be invalid without a published on date' do
      p = Factory.build(:picture, :published_on => nil)
      p.should_not be_valid
      p.errors[:published_on].should_not be_empty
    end
    
    it 'should be invalid with a published on date as an empty string' do
      p = Factory.build(:picture, :published_on => "")
      p.should_not be_valid
      p.errors[:published_on].should_not be_empty
    end
    
    it 'should be valid with a tag list' do
      p = Factory.build(:picture, :tag_list => "Apple, iPod")
      p.should be_valid
      p.errors[:tag_list].should be_empty
    end
    
    it 'should be valid without a tag list' do
      p = Factory.build(:picture, :tag_list => nil)
      p.should be_valid
      p.errors[:tag_list].should be_empty
    end
    
    it "should be invalid without a photoalbum" do
      p = Factory.build(:picture, :photoalbum => nil)
      p.should_not be_valid
      p.errors[:photoalbum].should_not be_empty
    end
  end
  
  describe 'associations' do
    it "should belong to user" do
      user = Factory.create(:user)
      picture = Factory.create(:picture, :author => user)
      picture.author.should == user
    end
    
    it "should belong to a photoalbum" do
      pa = Factory.create(:photoalbum)
      picture = Factory.create(:picture, :photoalbum => pa)
      picture.photoalbum.should == pa
    end
  end
end
