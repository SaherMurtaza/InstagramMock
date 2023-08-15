class AddDetailsToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :name, :string
    add_column :accounts, :image, :string
  end
end
