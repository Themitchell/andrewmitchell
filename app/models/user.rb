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

class User < ActiveRecord::Base
  include PaperclipHelper

  # Associations
  has_many        :authentications, :dependent => :destroy
  devise          :database_authenticatable,
                  :registerable,
                  :recoverable,
                  :rememberable,
                  :trackable,
                  :validatable,
                  :authentication_keys => [:login]
                  # others are:- :token_authenticatable, :lockable, :timeoutable and :activatable

  has_many        :posts,           :foreign_key => 'author_id', :dependent => :destroy
  has_many        :portfolio_items, :foreign_key => 'author_id', :dependent => :destroy
  has_many        :pictures,        :foreign_key => 'author_id', :dependent => :destroy
  has_many        :comments,        :foreign_key => 'author_id', :dependent => :destroy

  attr_accessible :username,
                  :email,
                  :password,
                  :password_confirmation
  attr_protected  :avatar_file_name,
                  :avatar_content_type,
                  :avatar_file_size
  attr_accessor   :login

  # Scopes
  scope :member,      :conditions => {:role => "member"}
  scope :admin,       :conditions => {:role => "admin"}
  scope :superadmin,  :conditions => {:role => "superadmin"}

  # Paperclip
  has_attached_file :avatar, { :styles => {:avatar => "50x50>"} }.merge(PAPERCLIP_OPTIONS)

  validates_attachment_content_type :avatar, :content_type => IMAGE_MIME_TYPES,
                                             :if => :has_avatar?,
                                             :message => 'Avatar should be a jpeg, gif or png.'


  # Validations
  validates :username, :presence => true, :uniqueness => true
  validates :role, :presence => true


  # Methods
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

  def oauth_enabled?
    authentications.any?
  end

  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.strip.downcase }]).first
  end

  def password_required?
    ( !oauth_enabled? || !password.blank? ) && super
  end

protected
  def email_required?
    false
  end

  # Attempt to find a user by it's email. If a record is found, send new
  # password instructions to it. If not user is found, returns a new user
  # with an email not found error.
  def self.send_reset_password_instructions(attributes={})
    recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    recoverable.send_reset_password_instructions if recoverable.persisted?
    recoverable
  end

  def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
    (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

    attributes = attributes.slice(*required_attributes)
    attributes.delete_if { |key, value| value.blank? }

    if attributes.size == required_attributes.size
      if attributes.has_key?(:login)
        login = attributes.delete(:login)
        record = find_record(login)
      else
        record = where(attributes).first
      end
    end

    unless record
      record = new

      required_attributes.each do |key|
        value = attributes[key]
        record.send("#{key}=", value)
        record.errors.add(key, value.present? ? error : :blank)
      end
    end
    record
  end

  def self.find_record(login)
    where(["username = :value OR email = :value", { :value => login }]).first
  end
end
