class Comment < ApplicationRecord
  belongs_to :post
  # validates :account_id, uniqueness: {scope: :post_id}
end
