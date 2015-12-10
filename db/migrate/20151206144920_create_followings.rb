class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.references :following, null: false
      t.references :followed, null: false

      t.timestamps null: false
    end

    add_index :followings, [ :following_id ]
    add_index :followings, [ :followed_id ]
    add_foreign_key :followings, :users, column: "following_id"
    add_foreign_key :followings, :users, column: "followed_id"
  end
end
