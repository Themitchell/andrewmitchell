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
  
  describe 'validations' do
    
    it "should be valid by default" do
      FactoryGirl.build(:content_block).should be_valid
    end
    
    context "presence" do
      it { should     validate_presence_of :name }
      it { should_not allow_value("").for  :name }
    end
    
    context "uniqueness" do
      before :each do
        FactoryGirl.create(:content_block)
      end
      
      it { should validate_uniqueness_of :name }
    end
  end
end
