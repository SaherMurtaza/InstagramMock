class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    belongs_to :account
    has_many :likes
    has_many :comments
    has_many_attached :images
end