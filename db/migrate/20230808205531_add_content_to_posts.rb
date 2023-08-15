class AddContentToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :caption, :string
    add_column :posts, :location, :string
  end
end
