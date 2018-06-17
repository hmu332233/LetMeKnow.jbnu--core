class CreateUserWords < ActiveRecord::Migration
  def change
    create_table :user_words do |t|

      t.string :user_key
      t.string :content
      
      t.timestamps
    end
  end
end
