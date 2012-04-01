# == Schema Information
#
# Table name: posts
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  body         :text
#  author_id    :integer
#  published_on :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  permalink    :string(255)
#  category_id  :integer
#

require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe Post do
  
  describe 'validations' do
    
    it "should be valid by default" do
      FactoryGirl.build(:post).should be_valid
    end
    
    context "presence" do
      it { should     validate_presence_of :title }
      it { should_not allow_value("").for  :title }
      it { should     validate_presence_of :body }
      it { should_not allow_value("").for  :body }
      it { should     validate_presence_of :author }
      it { should     validate_presence_of :published_on }
      it { should_not allow_value("").for  :body }
    end
    
    context "uniqueness" do
      before :each do
        FactoryGirl.create(:post)
      end
      
      it { should validate_uniqueness_of :title }
    end
  end
  
  describe 'associations' do
    
    it { should belong_to(:author).class_name('User') }
    it { should belong_to :category }
  end
  
  describe "permalink field" do
    it "should set the permalink based on the title" do
      p = FactoryGirl.create(:post, title: "Test Title")
      p.permalink.should == "test-title"
    end

    it "to_param should return the permalink" do
      p = FactoryGirl.create(:post, title: "Test Title")
      p.to_param.should == p.permalink
    end
  end
end
