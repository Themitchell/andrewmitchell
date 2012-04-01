# == Schema Information
#
# Table name: photoalbums
#
#  id           :integer         not null, primary key
#  author_id    :integer
#  name         :string(255)
#  description  :text
#  published_on :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  permalink    :string(255)
#

class Photoalbum < ActiveRecord::Base
  belongs_to      :author,          :class_name => "User"
  has_many        :pictures
  has_permalink   :name
  
  
  # Validations
  validates       :name,            :presence => true, :uniqueness => true
  validates       :description,     :presence => true
  validates       :author,          :presence => true
  validates       :published_on,    :presence => true
  
  # Delegations
  
  # Methods
  
  def display_item
    pictures.first
  end

  def to_param
    permalink
  end
end
