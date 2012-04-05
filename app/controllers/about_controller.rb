class AboutController < ApplicationController
  
  def index
    @personal_statement         = ContentBlock.find_by_name("personal statement")
  end
  
  def employment_history
    @employment_history         = EmploymentHistoryItem.order(["date_to DESC", "date_from DESC"]).all
  end
  
  def educational_qualifications
    @educational_qualifications = EducationalQualification.order(["date_to DESC", "date_from DESC"]).all
  end
end
