class CreateRetweetings < ActiveRecord::Migration
  def change
    create_table :retweetings do |t|
      t.references :tweet, index: true, foreign_key: true, null: false
      t.references :retweeted, null: false

      t.timestamps null: false
    end

    add_index :retweetings, [ :retweeted_id ]
    add_foreign_key :retweetings, :tweets, column: "retweeted_id"
  end
end
