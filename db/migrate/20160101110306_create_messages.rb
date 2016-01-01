class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :sendto, null: false
      t.text :content, null: false

      t.timestamps null: false
    end

    add_index :messages, [ :sendto_id ]
    add_foreign_key :messages, :users, column: "sendto_id"
  end
end
