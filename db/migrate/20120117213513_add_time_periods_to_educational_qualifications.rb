class AddTimePeriodsToEducationalQualifications < ActiveRecord::Migration
  def change
    add_column :educational_qualifications, :date_from, :date
    add_column :educational_qualifications, :date_to, :date
  end
end