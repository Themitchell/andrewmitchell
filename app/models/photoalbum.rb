class Photoalbum < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  has_many :pictures
  
  # Validations
  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates :author, :presence => true
  validates :published_on, :presence => true
end