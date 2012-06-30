# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  author_id  :integer
#  permalink  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe Category do
  before { FactoryGirl.create(:category) }
  it { should     validate_presence_of :name }
  it { should_not allow_value("").for  :name }
  it { should     validate_presence_of :author }
  it { should     validate_uniqueness_of :name }
  it { should     belong_to(:author).class_name('User') }

  describe "permalink field" do
    it "should set the permalink based on the title" do
      c = FactoryGirl.create(:category, name: "Test Title")
      c.permalink.should == "test-title"
    end

    it "to_param should return the permalink" do
      c = FactoryGirl.create(:category, name: "Test Title")
      c.to_param.should == c.permalink
    end
  end
end
