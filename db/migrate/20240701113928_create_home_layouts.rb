class CreateHomeLayouts < ActiveRecord::Migration[7.1]
  def change
    create_table :home_layouts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: true, foreign_key: true
      t.boolean :is_visible, default: true
      t.integer :position
      t.boolean :is_personal, default: false

      t.timestamps
    end
  end
end
