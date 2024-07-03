class CreateUserGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :user_groups do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.integer :role, null: false, default: 0  # '0 = member'

      t.timestamps
    end

    add_index :user_groups, [:user_id, :group_id], unique: true # 複数のグループ参加を防ぐ
  end
end
