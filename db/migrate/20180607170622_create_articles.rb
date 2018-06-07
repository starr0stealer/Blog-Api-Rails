class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.references :user, null: false, index: true, foreign_key: true

      t.string :slug,  null: false
      t.string :title, null: false
      t.text   :body,  null: false
      t.string :description

      t.timestamps null: false
    end

    add_index :articles, :slug, unique: true
  end
end
