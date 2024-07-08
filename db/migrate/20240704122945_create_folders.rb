class CreateFolders < ActiveRecord::Migration[7.1]
  def change
    create_table :folders do |t|
      t.string :name, null: false
      t.references :parent, foreign_key: { to_table: :folders }, null: true
      t.references :category, foreign_key: true, null: false
      t.references :group, foreign_key: true, null: true
      t.references :user, foreign_key: true, null: true
      t.integer :position, null: false

      t.timestamps
    end
  end
end
