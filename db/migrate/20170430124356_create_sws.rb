class CreateSws < ActiveRecord::Migration
  def change
    create_table :sws do |t|
      t.integer :menu, :default => 0

      t.timestamps null: false
    end
  end
end
