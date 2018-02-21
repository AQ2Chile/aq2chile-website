class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string   :name
      t.string   :email
      t.integer  :frags,          default: 0
      t.datetime :last_online
      t.boolean  :verified
      t.integer  :updates_count,  default: 0
      t.integer  :minutes_online, default: 0

      t.timestamps
    end
  end
end
