class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :tweet, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
