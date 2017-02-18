class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :name
      t.string :office, default: "x"
      t.string :tel, default:  "x"
      t.string :fax, default: "x"

      t.timestamps null: false
    end
  end
end
