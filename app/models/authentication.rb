# == Schema Information
#
# Table name: authentications
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Authentication < ActiveRecord::Base
    
  # Asscoiations
  belongs_to :user
  
  # Validations
  validates :provider,  :presence => true
  validates :user_id,   :presence => true
  validates :uid,       :presence => true, :uniqueness => { :scope => :provider }
end
