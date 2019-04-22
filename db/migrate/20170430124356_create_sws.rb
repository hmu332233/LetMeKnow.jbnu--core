class CreateSws < ActiveRecord::Migration
  def change
    create_table :sws do |t|
      t.integer :menu, :default => 0
      t.boolean :use_mobile_menu, :default => true
      t.boolean :use_db_menu, :default => true
      t.boolean :use_yesterday_domitory_menu, :default => false
      
      t.timestamps null: false
    end
  end
end
