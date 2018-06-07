class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.string :author
      t.text :message

      t.timestamps
    end
  end
end
