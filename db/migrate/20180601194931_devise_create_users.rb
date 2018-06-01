class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Profile Fields
      t.string :username, null: false
      t.text   :bio
      t.text   :image

      t.timestamps null: false
    end

    add_index :users, :email,    unique: true
    add_index :users, :username, unique: true
  end
end
