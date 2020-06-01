class CreateTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :topics do |t|
      t.string :alias
      t.string :title

      t.timestamps
    end
  end
end
