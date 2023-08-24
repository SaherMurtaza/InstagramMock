class RemoveRoleFromAccounts < ActiveRecord::Migration[7.0]
  def change
    remove_column :accounts, :role, :integer
  end
end
