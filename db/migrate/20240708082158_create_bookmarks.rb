class CreateBookmarks < ActiveRecord::Migration[7.1]
  def change
    create_table :bookmarks do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.integer :type, default: 0, null: false
      t.references :folder, foreign_key: true, null: true
      t.references :category, foreign_key: true, null: true
      t.references :group, foreign_key: true, null: true
      t.references :user, foreign_key: true, null: true
      t.integer :position, null: false
      t.text :description

      t.timestamps
    end
  end
end
