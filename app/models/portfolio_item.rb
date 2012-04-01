# == Schema Information
#
# Table name: portfolio_items
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  permalink    :string(255)
#  description  :string(255)
#  published_on :datetime
#  author_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class PortfolioItem < ActiveRecord::Base
  
  # Associations
  belongs_to      :author,        :class_name => "User"
  has_one         :media_asset,   :as => :owner,        :class_name => 'MediaAsset'
  

  has_permalink   :title
    
  # Validations
  validates       :title,         :presence => true,    :uniqueness => true
  validates       :description,   :presence => true
  validates       :author,        :presence => true
  validates       :published_on,  :presence => true
  
  accepts_nested_attributes_for :media_asset
  
  def to_param
    permalink
  end
end
