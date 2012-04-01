class CreateEmploymentHistoryItems < ActiveRecord::Migration
  def change
    create_table :employment_history_items do |t|
      t.string :company_name
      t.string :company_role
      t.text :role_description
      t.date :date_from
      t.date :date_to
      t.string :location

      t.timestamps
    end
  end
end
