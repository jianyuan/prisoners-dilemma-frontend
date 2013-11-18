class AddIcUsernameNameDescriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ic_username, :string
    add_column :users, :name, :string
    add_column :users, :description, :text
  end
end
