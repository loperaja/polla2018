class ChangePointsDefaultValueInPolla < ActiveRecord::Migration[5.2]
  def change
    remove_column :pollas, :pints
    add_column :pollas, :points, :integer, :default => 0
  end
  
end
