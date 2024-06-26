class SorceryCore < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :crypted_password
      t.string :salt
      t.string :name
      t.string :user_name, null: false
      t.string :avatar

      t.timestamps null: false
    end
  end
end
