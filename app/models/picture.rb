# == Schema Information
#
# Table name: pictures
#
#  id                   :integer         not null, primary key
#  title                :string(255)
#  description          :text
#  author_id            :integer
#  published_on         :datetime
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  created_at           :datetime
#  updated_at           :datetime
#  photoalbum_id        :integer
#  permalink            :string(255)
#

class Picture < ActiveRecord::Base
  include PaperclipHelper

  attr_protected :picture_file_name, :picture_content_type, :picture_file_size
  belongs_to :author, :class_name => "User"
  belongs_to :photoalbum
  has_permalink :title
  
  
  has_many :comments, :as => :commentable, :order => 'created_at DESC', :dependent => :destroy
  acts_as_taggable_on :tags
  
  # Paperclip 
  has_attached_file :picture, { :styles => {:picture => "600x", :preview => "166x100#", :thumbnail => "100x75>"} }.merge(PAPERCLIP_OPTIONS)

  validates_attachment_content_type :picture, :content_type => IMAGE_MIME_TYPES,
                                              :if => :has_picture?,
                                              :message => 'Picture should be a jpeg, gif or png.'
  
  validates_attachment_presence :picture, :message => 'Please upload an image.'                                       

  # Validations
  validates :title, :presence => true, :uniqueness => true
  validates :author, :presence => true
  validates :photoalbum, :presence => true
  validates :published_on, :presence => true
  
  def to_param
    permalink
  end
end
