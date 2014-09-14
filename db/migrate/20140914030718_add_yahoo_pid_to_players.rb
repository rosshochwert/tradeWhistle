class AddYahooPidToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :yahoo_pid, :string
  end
end
