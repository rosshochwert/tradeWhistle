class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.int :number
      t.references :team, index: true

      t.timestamps
    end
  end
end
