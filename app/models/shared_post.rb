class SharedPost < ApplicationRecord
  belongs_to :post, foreign_key: "post_id"
  belongs_to :account
end
