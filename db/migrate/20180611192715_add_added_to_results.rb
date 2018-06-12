class AddAddedToResults < ActiveRecord::Migration[5.2]
  def change
    add_column :results, :added, :boolean, default: false
    add_column :pollas, :real, :boolean, default: false
  end

  def down
    remove_column :results, :added
    remove_column :pollas, :real
  end
end
