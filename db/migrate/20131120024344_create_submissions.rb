class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :user, index: true
      t.references :game_round, index: true
      t.string :name
      t.binary :code

      t.timestamps
    end
  end
end
