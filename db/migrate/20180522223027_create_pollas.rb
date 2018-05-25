class CreatePollas < ActiveRecord::Migration[5.2]
  def change
    create_table :pollas do |t|
      t.string :name
      t.integer :user_id
      t.integer :points


      t.timestamps
    end

    add_index :pollas, :user_id

    remove_column :results, :user_id
    add_column :results, :polla_id, :integer

    add_index :results, :polla_id
  end
end
