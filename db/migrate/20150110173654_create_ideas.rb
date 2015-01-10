class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.text :content
      t.belongs_to :user
      t.integer :score, null: false, default: 0

      t.timestamps null: false
    end
  end
end
