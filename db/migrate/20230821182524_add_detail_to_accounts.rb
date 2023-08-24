class AddDetailToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :role, :string, default: "user"
    add_column :accounts, :active, :boolean, default: true
  end
end
