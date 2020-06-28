class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.integer :parent_id
      t.string :body

      t.timestamps
    end
    add_index :comments, :post_id
  end
end
