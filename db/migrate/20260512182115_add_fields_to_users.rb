class AddFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role, :integer
    add_column :users, :university, :string
    add_column :users, :institutional_email, :string
    add_column :users, :credential_photo, :string
    add_column :users, :phone, :string
  end
end
