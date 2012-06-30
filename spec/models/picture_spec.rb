# == Schema Information
#
# Table name: pictures
#
#  id                   :integer         not null, primary key
#  title                :string(255)
#  description          :text
#  author_id            :integer
#  published_on         :datetime
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  created_at           :datetime
#  updated_at           :datetime
#  photoalbum_id        :integer
#  permalink            :string(255)
#

require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe Picture do
  before { FactoryGirl.create(:picture) }
  it { should     validate_presence_of :title }
  it { should_not allow_value("").for  :title }
  it { should     validate_presence_of :photoalbum }
  it { should     validate_presence_of :author }
  it { should     validate_presence_of :published_on }
  it { should_not allow_value("").for  :published_on }
  it { should     validate_presence_of(:picture).with_message(/Please upload an image./) }
  it { should validate_uniqueness_of :title }

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to :photoalbum }
  end

  describe "permalink field" do
    it "should set the permalink based on the title" do
      p = FactoryGirl.create(:picture, title: "Test Title")
      p.permalink.should == "test-title"
    end

    it "to_param should return the permalink" do
      p = FactoryGirl.create(:picture, title: "Test Title")
      p.to_param.should == p.permalink
    end
  end
end
