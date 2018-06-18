class AddPointsAwardedToPointHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :point_histories, :points_awarded, :integer
    PointHistory.all.each do |p|
      points_earned = (p.result.resultable_type == "Match") ? 1 : p.result.resultable.points
      p.update_attributes(:points_awarded => points_earned)
    end
  end

  def down
    remove_column :point_histories, :points_awarded

  end
end
