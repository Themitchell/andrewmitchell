# == Schema Information
#
# Table name: users
#
#  id                   :integer(4)      not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer(4)      default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  username             :string(255)
#  role                 :string(255)     default("member")
#  first_name           :string(255)
#  last_name            :string(255)
#  dob                  :date
#  website_url          :string(255)
#  avatar_file_name     :string(255)
#  avatar_content_type  :string(255)
#  avatar_file_size     :integer(4)
#

require 'spec_helper'

describe User do
  
  describe 'validations' do
    it 'should be invalid without an email' do
      u = Factory.build(:user, :email => nil)
      u.should_not be_valid
      u.errors['email'].should_not be_nil
    end
    
    it 'should be invalid with an email as an empty string' do
      u = Factory.build(:user, :email => "")
      u.should_not be_valid
      u.errors['email'].should_not be_nil
    end
    
    it 'should be invalid with something which does not look like an email' do 
      u = Factory.build(:user, :email => 'this is not an email address')
      u.should_not be_valid
      u.errors['email'].should_not be_nil
    end
    
    it 'should not be valid with an email which already exists' do
      u = Factory.create(:user)
      u2 = Factory.build(:user, :email => u.email)
      u2.should_not be_valid
    end
    
    it 'should be invalid without a name' do
      u = Factory.build(:user, :username => nil)
      u.should_not be_valid
      u.errors['name'].should_not be_nil
    end
    
    it 'should be invalid with a name as an empty string' do
      u = Factory.build(:user, :username => "")
      u.should_not be_valid
      u.errors['name'].should_not be_nil
    end
    
    it "should be invalid with a name that already exists" do
      Factory.create(:user, :username => "a photoalbum")
      u = Factory.build(:user, :username => "a photoalbum")
      u.should_not be_valid
      u.errors[:username].should_not be_empty
    end
    
    it 'should not be valid without a password' do
      u = Factory.build(:user, :password => nil)
      u.should_not be_valid
      u.errors['password'].should_not be_nil
    end
    
    it 'should not be valid with a password as an empty string' do
      u = Factory.build(:user, :password => "")
      u.should_not be_valid
      u.errors['password'].should_not be_nil
    end
  end
  
  describe "is_admin?" do
    it "should return true if user is superadmin" do
      user = Factory.create(:user, :role => "superadmin")
      user.is_admin?.should be_true
    end
    
    it "should return true if user is admin" do
      user = Factory.create(:user, :role => "admin")
      user.is_admin?.should be_true
    end

    it "should return false if user is not admin or a super admin" do
      user = Factory.create(:user, :role => "member")
      user.is_admin?.should be_false
    end
  end
end
