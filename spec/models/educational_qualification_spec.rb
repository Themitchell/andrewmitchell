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

require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe EducationalQualification do
  it { should     validate_presence_of :name }
  it { should_not allow_value("").for  :name }
  it { should     validate_presence_of :institution }
  it { should_not allow_value("").for  :institution }
  it { should     validate_presence_of :date_from }
  it { should_not allow_value("").for  :date_from }
end
