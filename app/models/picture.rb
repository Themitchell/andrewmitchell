# == Schema Information
#
# Table name: pictures
#
#  id                   :integer(4)      not null, primary key
#  title                :string(255)
#  description          :text
#  author_id            :integer(4)
#  published_on         :date
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer(4)
#  created_at           :datetime
#  updated_at           :datetime
#

class Picture < ActiveRecord::Base
  include PaperclipHelper

  attr_protected :picture_file_name, :picture_content_type, :picture_file_size
  belongs_to :author, :class_name => "User"
  belongs_to :photoalbum
  
  has_many :comments, :as => :commentable, :order => 'created_at DESC', :dependent => :destroy
  acts_as_taggable_on :tags
  
  # Paperclip 
  has_attached_file :picture, :styles => {:picture => "600x", :thumbnail => "100x75>"},
                             :whiny => false,
                             :url => "/#{PAPERCLIP_PATH}/:class/:attachment/:id/:style/:basename.:extension",
                             :path => ":rails_root/public/#{PAPERCLIP_PATH}/:class/:attachment/:id/:style/:basename.:extension"

  validates_attachment_content_type :picture, :content_type => ['image/png','image/x-png', 'image/jpg', 'image/jpeg','image/pjpeg', 'image/gif'],
                                             :message => 'Picture should be a jpeg, gif or png.',
                                             :if => :has_picture?,
                                             :message => 'Picture should be a jpeg, gif or png.'
  
  validates_attachment_presence :picture, :message => 'Please upload an image.'                                       

  # Validations
  validates :title, :presence => true, :uniqueness => true
  validates :author, :presence => true
  validates :photoalbum, :presence => true
  validates :published_on, :presence => true
end
