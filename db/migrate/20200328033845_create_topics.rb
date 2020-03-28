class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :title
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :topics, [:user_id, :created_at]
  end
end
