class CreateAlgorithms < ActiveRecord::Migration
  def change
    create_table :algorithms do |t|
      t.references :user, index: true
      t.string :name
      t.text :code
      t.string :privacy

      t.timestamps
    end
  end
end
