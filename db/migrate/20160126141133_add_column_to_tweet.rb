class AddColumnToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :retweet_id, :integer
    add_foreign_key :tweets, :tweets, column: "retweet_id"
  end
end
