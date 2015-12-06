class CreateRetweetingRelationships < ActiveRecord::Migration
  def change
    create_table :retweeting_relationships do |t|
      t.references :tweet, index: true, foreign_key: true, null: false
      t.references :retweeted, null: false

      t.timestamps null: false
    end

    add_index :retweeting_relationships, [ :retweeted_id ]
    add_foreign_key :retweeting_relationships, :tweets, column: "retweeted_id"
  end
end
