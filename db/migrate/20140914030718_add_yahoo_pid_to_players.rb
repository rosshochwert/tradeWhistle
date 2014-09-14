class AddYahooPidToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :yahoo_pid, :integer
  end
end
