# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  encrypted_password   :string(128)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
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
#  avatar_file_size     :integer
#  email                :string(255)
#

require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe User do
  before { FactoryGirl.create(:user) }
  it { should     validate_presence_of  :username }
  it { should_not allow_value("").for   :username }
  it { should     validate_presence_of  :password }
  it { should_not allow_value("").for   :password }
  it { should     validate_uniqueness_of :email }
  it { should     validate_uniqueness_of :username }
  it { should     have_many(:authentications).dependent :destroy }
  it { should     have_many(:posts).          dependent :destroy }
  it { should     have_many(:portfolio_items).dependent :destroy }
  it { should     have_many(:pictures).       dependent :destroy }
  it { should     have_many(:comments).       dependent :destroy }

  describe "is_admin?" do
    it "should return true if user is superadmin" do
      FactoryGirl.build(:user, role: "superadmin").is_admin?.should be_true
    end

    it "should return true if user is admin" do
      FactoryGirl.build(:user, role: "admin").is_admin?.should be_true
    end

    it "should return false if user is not admin or a super admin" do
      FactoryGirl.build(:user, role: "member").is_admin?.should be_false
    end
  end
  
  describe "is_superadmin?" do
    it "should return true if user is superadmin" do
      FactoryGirl.build(:user, role: "superadmin").is_superadmin?.should be_true
    end

    it "should return true if user is admin" do
      FactoryGirl.build(:user, role: "admin").is_superadmin?.should be_false
    end

    it "should return false if user is not admin or a super admin" do
      FactoryGirl.build(:user, role: "member").is_superadmin?.should be_false
    end
  end
end
