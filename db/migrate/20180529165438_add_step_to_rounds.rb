class AddStepToRounds < ActiveRecord::Migration[5.2]
  def change
    add_column :rounds, :step, :string
    add_index :rounds, :step
  end
end
