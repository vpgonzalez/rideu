class AddNameToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :license_verified, :boolean
    add_column :users, :credential_verified, :boolean
  end
end
