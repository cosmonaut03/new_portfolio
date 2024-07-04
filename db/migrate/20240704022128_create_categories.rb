class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.references :user, foreign_key: true, null: true
      t.references :group, foreign_key: true, null: true
      t.string :name, null: false
      t.text :description
      t.integer :position, null: false
      t.boolean :is_uncategorized, default: false, null: false

      t.timestamps
    end

    add_index :categories, [:user_id, :is_uncategorized], unique: true, where: 'is_uncategorized = true'
    add_index :categories, [:group_id, :is_uncategorized], unique: true, where: 'is_uncategorized = true'
  end
end
