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
  
  describe "validations" do
    it "should be valid by default" do
      FactoryGirl.build(:authentication).should be_valid
    end
    
    context "presence" do
      it { should validate_presence_of :provider }
      it { should validate_presence_of :uid }
      it { should validate_presence_of :user_id }
    end
    
    context "uniqueness" do
      before :each do
        FactoryGirl.create(:authentication)
      end
      
      it { should validate_uniqueness_of(:uid).scoped_to :provider }
    end
  end
  
  describe "associations" do
    it { should belong_to :user }
  end
end
