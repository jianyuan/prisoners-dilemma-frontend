class ChangeDataTypeForCodeToText < ActiveRecord::Migration
  def up
    change_column :algorithms, :code, :text
    change_column :submissions, :code, :text
  end

  def down
    change_column :algorithms, :code, :binary
    change_column :submissions, :code, :binary
  end
end
