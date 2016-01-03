class CreateDmmessages < ActiveRecord::Migration
  def change
    create_table :dmmessages do |t|
      t.references :dm, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
