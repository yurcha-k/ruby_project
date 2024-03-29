class CreatePost < ActiveRecord::Migration[6.1]
    def change
      create_table :posts do |t|
        t.string :title
        t.text :text
        t.belongs_to :category, null: false, foreign_key: true
  
        t.timestamps
      end
    end
  end