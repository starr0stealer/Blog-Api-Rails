class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user,    null: false, index: true, foreign_key: true
      t.references :article, null: false, index: true, foreign_key: true

      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
