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

require File.expand_path(File.dirname(__FILE__) + '../../support/spec_helper')

describe EmploymentHistoryItem do
  it { should     validate_presence_of :company_name }
  it { should_not allow_value("").for  :company_name }
  it { should     validate_presence_of :company_role }
  it { should_not allow_value("").for  :company_role }
  it { should     validate_presence_of :date_from }
  it { should_not allow_value("").for  :date_from }
end
