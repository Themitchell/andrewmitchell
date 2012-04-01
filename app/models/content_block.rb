# == Schema Information
#
# Table name: content_blocks
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class ContentBlock < ActiveRecord::Base
  
  # Validations
  validates :name, :presence => true, :uniqueness => true
  
end
