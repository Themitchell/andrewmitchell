class CreateEducationalQualifications < ActiveRecord::Migration
  def change
    create_table :educational_qualifications do |t|
      t.string :name
      t.string :institution
      t.string :grade

      t.timestamps
    end
  end
end
