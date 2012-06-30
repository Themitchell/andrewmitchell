# == Schema Information
#
# Table name: content_blocks
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe ContentBlock do
  before { FactoryGirl.create(:content_block) }
  it { should     validate_presence_of :name }
  it { should_not allow_value("").for  :name }
  it { should     validate_uniqueness_of :name }
end
