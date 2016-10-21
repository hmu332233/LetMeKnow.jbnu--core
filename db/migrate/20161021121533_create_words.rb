class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      
      t.string :content
      t.integer :count, :default => 0

      t.timestamps null: false
    end
  end
end
