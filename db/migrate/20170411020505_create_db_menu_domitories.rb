class CreateDbMenuDomitories < ActiveRecord::Migration
  def change
    create_table :db_menu_domitories do |t|
      t.string :week
      t.string :breakfast
      t.string :lunch
      t.string :dinner

      t.timestamps null: false
    end
  end
end
