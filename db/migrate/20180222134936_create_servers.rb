class CreateServers < ActiveRecord::Migration[5.1]
  def change
    create_table :servers do |t|
      t.string :name
      t.string :address
      t.integer :port
      t.string :country
      t.string :game

      t.timestamps
    end
  end
end
