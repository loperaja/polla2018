class AddTimezoneToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :timezone, :string, default: "Bogota"
  end

  def down
    remove_column :users, :timezone
  end
end
