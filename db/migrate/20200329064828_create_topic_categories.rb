class CreateTopicCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :topic_categories do |t|
      t.integer :topic_id
      t.integer :category_id

      t.timestamps
    end
    add_index :topic_categories, :topic_id
    add_index :topic_categories, :category_id
    add_index :topic_categories, [:topic_id,:category_id],unique: true
  end
end
