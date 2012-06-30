# == Schema Information
#
# Table name: authentications
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe Authentication do
  before { FactoryGirl.create(:authentication) }
  it { should validate_presence_of :provider }
  it { should validate_presence_of :uid }
  it { should validate_presence_of :user_id }
  it { should belong_to :user }
  it { should validate_uniqueness_of(:uid).scoped_to :provider }
end
