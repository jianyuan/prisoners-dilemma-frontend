class CreateGameRounds < ActiveRecord::Migration
  def change
    create_table :game_rounds do |t|
      t.string :name
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
