class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.integer :created_by
      t.integer :topic_id

      t.timestamps
    end
  end
end
