# == Schema Information
#
# Table name: posts
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  body         :text
#  author_id    :integer
#  published_on :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  permalink    :string(255)
#  category_id  :integer
#

class Post < ActiveRecord::Base
  include Displayable

  # Attributes
  attr_accessible :title, :body, :published_on, :category_id, :author_id

  # Relationships
  belongs_to  :author,    :class_name => "User"
  belongs_to  :category
  has_many    :comments,  :as => :commentable, :order => 'created_at DESC', :dependent => :destroy

  acts_as_taggable_on :tags
  has_permalink :title

  # Validations
  validates :title,         :presence => true, :uniqueness => true
  validates :body,          :presence => true
  validates :author,        :presence => true
  validates :published_on,  :presence => true
  validates :category,      :presence => true

  # Scopes
  scope :from_category, lambda { |category| where(:category_id => category.id) }

  def to_param
    permalink
  end
end
