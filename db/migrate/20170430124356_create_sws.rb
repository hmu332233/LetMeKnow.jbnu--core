class CreateSws < ActiveRecord::Migration
  def change
    create_table :sws do |t|
      t.integer :menu, :default => 0
      t.boolean :use_mobile_menu, :default => true
      t.boolean :use_db_menu, :default => true
      t.boolean :use_yesterday_domitory_menu, :default => false
      
      t.boolean :use_db_medi, :default => true
      t.boolean :use_db_hu, :default => true
      t.boolean :use_db_jungdam, :default => true
      t.boolean :use_db_jinsu, :default => true
      t.boolean :use_db_student_hall, :default => true
      
      t.timestamps null: false
    end
  end
end
