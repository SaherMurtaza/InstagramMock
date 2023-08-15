class Post < ApplicationRecord
  belongs_to :account
  has_many :comments, dependent: :destroy
  has_many :likes, -> {order(:created_at => :desc)}
  has_one_attached :images
  def is_belongs_to? account
    Post.find_by(account_id: account.id, id: id)
  end

end
