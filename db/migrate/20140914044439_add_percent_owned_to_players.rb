class AddPercentOwnedToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :percentOwned, :integer
  end
end
