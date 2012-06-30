# == Schema Information
#
# Table name: portfolio_items
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  permalink    :string(255)
#  description  :string(255)
#  published_on :datetime
#  author_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe PortfolioItem do
  before { FactoryGirl.create(:portfolio_item) }
  it { should     validate_presence_of  :title }
  it { should_not allow_value("").for   :title }
  it { should     validate_presence_of  :description }
  it { should_not allow_value("").for   :description }
  it { should     validate_presence_of  :author }
  it { should     validate_presence_of  :published_on }
  it { should_not allow_value("").for   :published_on }
  it { should     validate_uniqueness_of :title }
  it { should     belong_to(:author).class_name('User') }
  it { should     have_one(:media_asset) }
  # it { should     belong_to :category }

  describe "permalink field" do
    it "should set the permalink based on the title" do
      p = FactoryGirl.create(:portfolio_item, title: "Test Title")
      p.permalink.should == "test-title"
    end

    it "to_param should return the permalink" do
      p = FactoryGirl.create(:portfolio_item, title: "Test Title")
      p.to_param.should == p.permalink
    end
  end
end
