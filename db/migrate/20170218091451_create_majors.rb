class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :name
      t.string :office, default: ""
      t.string :tel, default:  ""
      t.string :fax, default: ""

      t.timestamps null: false
    end
  end
end
