class CreateFollowingRelationships < ActiveRecord::Migration
  def change
    create_table :following_relationships do |t|
      t.references :following, null: false
      t.references :followed, null: false

      t.timestamps null: false
    end

    add_index :following_relationships, [ :following_id ]
    add_index :following_relationships, [ :followed_id ]
    add_foreign_key :following_relationships, :users, column: "following_id"
    add_foreign_key :following_relationships, :users, column: "followed_id"
  end
end
