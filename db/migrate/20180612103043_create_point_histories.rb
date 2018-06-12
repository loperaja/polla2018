class CreatePointHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :point_histories do |t|
      t.integer :polla_id
      t.integer :result_id
      t.integer :points

      t.timestamps
    end
    add_index :point_histories, :polla_id
    add_index :point_histories, :result_id
  end
end
