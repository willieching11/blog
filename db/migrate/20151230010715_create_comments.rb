class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :context
      t.integer :article_id

      t.timestamps null: false
    end
  end
end
