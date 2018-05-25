class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer :home_team_id, :index
      t.integer :away_team_id, :index

      t.timestamps
    end
    add_index :matches, :home_team_id
    add_index :matches, :away_team_id
  end
end
