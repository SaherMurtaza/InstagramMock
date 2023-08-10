class Comment < ApplicationRecord
  belongs_to :posts
  belongs_to :account
end
