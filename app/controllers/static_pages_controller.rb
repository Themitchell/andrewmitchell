class StaticPagesController < ApplicationController
  def about
    @personal_statement         = ContentBlock.find_by_name("personal statement")
    @employment_history         = EmploymentHistoryItem.order(["date_to DESC", "date_from DESC"]).all
    @educational_qualifications = EducationalQualification.order(["date_to DESC", "date_from DESC"]).all
  end
  
  def contact
  end
end
