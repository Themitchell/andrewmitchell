# == Schema Information
#
# Table name: employment_history_items
#
#  id               :integer         not null, primary key
#  company_name     :string(255)
#  company_role     :string(255)
#  role_description :text
#  date_from        :date
#  date_to          :date
#  location         :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class EmploymentHistoryItem < ActiveRecord::Base
  include Displayable

  # Attributes
  attr_accessible :company_name, :company_role, :role_description, :date_from, :date_to, :location

  validates :company_name,  :presence => true
  validates :company_role,  :presence => true
  validates :date_from,     :presence => true
end
