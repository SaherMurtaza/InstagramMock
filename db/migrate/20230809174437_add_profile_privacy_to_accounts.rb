class AddProfilePrivacyToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :profile_privacy, :integer, default: 0

  end
end
