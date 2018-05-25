class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.integer :user_id, :index
      t.integer :result
      t.integer :resultable_id, :index
      t.string :resultable_type, :index

      t.timestamps
    end
    add_index :results, :user_id
  end
end
