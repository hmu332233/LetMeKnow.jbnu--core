class CreateHits < ActiveRecord::Migration
  def change
    create_table :hits do |t|
      
      t.string :name
      
      t.integer :connect_hits, default: 0
      
      t.integer :all_hits, default: 0
      t.integer :help_hits, default: 0
      
      t.integer :notice_hits, default: 0
      t.integer :domi_hits, default: 0
      t.integer :office_hits, default: 0
      t.integer :chik_hits, default: 0

      t.timestamps null: false
    end
  end
end
