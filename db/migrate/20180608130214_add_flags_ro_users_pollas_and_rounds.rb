class AddFlagsRoUsersPollasAndRounds < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean
    add_column :pollas, :paid, :boolean
    add_column :rounds, :added, :boolean
    add_column :matches, :added, :boolean
    add_column :matches, :date, :datetime
    add_column :rounds, :date, :datetime
  end
end
