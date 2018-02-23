class AddLastAvailableToServer < ActiveRecord::Migration[5.1]
  def change
    add_column :servers, :last_available, :datetime
  end
end
