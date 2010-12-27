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

class User < ActiveRecord::Base
  include PaperclipHelper
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation
  attr_protected :avatar_file_name, :avatar_content_type, :avatar_file_size
  has_many :posts, :foreign_key => 'author_id', :dependent => :destroy
  has_many :pictures, :foreign_key => 'author_id', :dependent => :destroy
  has_many :comments, :foreign_key => 'author_id', :dependent => :destroy
          
  scope :member, :conditions => {:role => "member"}
  scope :admin, :conditions => {:role => "admin"}
  scope :superadmin, :conditions => {:role => "superadmin"}
  
  
  # Paperclip 
  has_attached_file :avatar, :styles => {:avatar => "50x50>"},
                             :whiny => false,
                             :url => "/#{PAPERCLIP_PATH}/:class/:attachment/:id/:style/:basename.:extension",
                             :path => ":rails_root/public/#{PAPERCLIP_PATH}/:class/:attachment/:id/:style/:basename.:extension"

  validates_attachment_content_type :avatar, :content_type => ['image/png','image/x-png', 'image/jpg', 'image/jpeg','image/pjpeg', 'image/gif'],
                                             :message => 'Avatar should be a jpeg, gif or png.',
                                             :if => :has_avatar?,
                                             :message => 'Avatar should be a jpeg, gif or png.'
                                             

  # Validations
  validates :username, :presence => true, :uniqueness => true
  validates :role, :presence => true
  
  def is_admin?
    if self.role == "admin" || self.role == "superadmin"
      return true
    else
      return false
    end
  end
  
  def is_superadmin?
    if self.role == "superadmin"
      return true
    else
      return false
    end
  end
  
end
