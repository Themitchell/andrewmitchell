# == Schema Information
#
# Table name: posts
#
#  id           :integer(4)      not null, primary key
#  title        :string(255)
#  body         :text
#  author_id    :integer(4)
#  published_on :date
#  created_at   :datetime
#  updated_at   :datetime
#

class Post < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  has_many :comments, :as => :commentable, :order => 'created_at DESC', :dependent => :destroy
  acts_as_taggable_on :tags
  
  validates :title, :presence => true
  validates :body, :presence => true
  validates :author, :presence => true
  validates :published_on, :presence => true
end
