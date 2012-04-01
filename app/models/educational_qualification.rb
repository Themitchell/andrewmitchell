# == Schema Information
#
# Table name: educational_qualifications
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  institution :string(255)
#  grade       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  date_from   :date
#  date_to     :date
#

class EducationalQualification < ActiveRecord::Base
  
  validates :name,        :presence => true
  validates :institution, :presence => true
  validates :date_from,   :presence => true
end
