class CreateDmusers < ActiveRecord::Migration
  def change
    create_table :dm_users do |t|
      t.references :dm, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
