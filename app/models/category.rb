# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  author_id  :integer
#  permalink  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  has_permalink :name
  
  # Validations
  validates :name, :presence => true, :uniqueness => true
  validates :author, :presence => true
  
  def to_param
    permalink
  end
end
