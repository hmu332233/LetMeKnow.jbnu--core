class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :name
      t.string :office
      t.string :tel
      t.string :fax

      t.timestamps null: false
    end
  end
end
