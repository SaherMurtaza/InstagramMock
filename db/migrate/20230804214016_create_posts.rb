class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.boolean :active
      t.references :account
      t.timestamps
    end
  end
end
