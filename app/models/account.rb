class Account < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments
  has_many :followed_accounts, foreign_key: :follower_id, class_name: "Relationship"
  has_many :followees, through: :followed_accounts
  has_many :following_accounts, foreign_key: :followee_id, class_name: "Relationship"
  has_many :followers, through: :following_accounts

  enum profile_privacy: { public: 0, private: 1 }, _prefix: :profile

  scope :public_accounts_with_most_followers, lambda {
    where(profile_privacy: :public)
      .joins(:followers)
      .group('accounts.id')
      .order('COUNT(accounts.id) DESC')
      .limit(10)
  }

  def visible_posts(current_account)
    if profile_privacy == 'public'
      Post.where(account_id: id)
    elsif profile_privacy == 'private'
      if current_account && (current_account == self || current_account.followers?(self))
        Post.where(account_id: id)
      else
        Post.none
      end
    end
  end

  def likes?(post)
    likes.exists?(post:)
  end

  protected
  def password_required?
    confirmed? ? super : false
  end
end
