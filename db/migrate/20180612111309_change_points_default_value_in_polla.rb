class ChangePointsDefaultValueInPolla < ActiveRecord::Migration[5.2]
  def change
    remove_column :pollas, :points
    add_column :pollas, :points, :integer, :default => 0
  end
  
end
