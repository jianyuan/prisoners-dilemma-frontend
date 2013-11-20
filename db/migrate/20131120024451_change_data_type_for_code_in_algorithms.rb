class ChangeDataTypeForCodeInAlgorithms < ActiveRecord::Migration
  def up
    change_column :algorithms, :code, :binary
  end

  def down
    change_column :algorithms, :code, :text
  end
end
