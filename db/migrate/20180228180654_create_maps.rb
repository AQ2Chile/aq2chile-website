class CreateMaps < ActiveRecord::Migration[5.1]
  def change
    create_table :maps do |t|
      t.string :name
      t.boolean :in_rotation
      t.boolean :in_maplist

      t.timestamps
    end
  end
end
