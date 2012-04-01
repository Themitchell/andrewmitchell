# == Schema Information
#
# Table name: photoalbums
#
#  id           :integer         not null, primary key
#  author_id    :integer
#  name         :string(255)
#  description  :text
#  published_on :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  permalink    :string(255)
#

require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe Photoalbum do

  describe 'validations' do

    it "should be valid by default" do
      FactoryGirl.build(:photoalbum).should be_valid
    end

    context "presence" do
      it { should     validate_presence_of :name }
      it { should_not allow_value("").for  :name }
      it { should     validate_presence_of :description }
      it { should_not allow_value("").for  :description }
      it { should     validate_presence_of :author }
      it { should     validate_presence_of :published_on }
      it { should_not allow_value("").for  :published_on }
    end
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many :pictures }
  end
  
  describe ".picture" do
    it "should return the first picture in the set" do
      p = FactoryGirl.create(:photoalbum)
      first_pic = FactoryGirl.create(:picture, photoalbum: p)
      5.times{ FactoryGirl.create(:picture, photoalbum: p) }
      p.display_item.should == first_pic
    end
  end

  describe "permalink field" do
    it "should set the permalink based on the title" do
      p = FactoryGirl.create(:photoalbum, name: "Test Title")
      p.permalink.should == "test-title"
    end

    it "to_param should return the permalink" do
      p = FactoryGirl.create(:photoalbum, name: "Test Title")
      p.to_param.should == p.permalink
    end
  end
end
