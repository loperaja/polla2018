class AddNumTeamsToRounds < ActiveRecord::Migration[5.2]
  def change
    add_column :rounds, :num_teams, :integer
  end
end
