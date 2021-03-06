# == Schema Information
#
# Table name: comments
#
#  id               :integer         not null, primary key
#  body             :text
#  author_id        :integer
#  created_at       :datetime
#  updated_at       :datetime
#  commentable_id   :integer
#  commentable_type :string(255)
#

require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe Comment do
  it { should     validate_presence_of :body }
  it { should_not allow_value("").for  :body }
  it { should     validate_presence_of :author }
  it { should     belong_to(:author).class_name('User') }
  it { should     belong_to :commentable }
end
