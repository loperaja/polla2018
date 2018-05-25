class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :group

      t.timestamps
    end
  end

  def down

    remove_table :teams

  end
end
