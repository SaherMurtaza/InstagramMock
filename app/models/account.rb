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

  has_one_attached :avatar

  has_many :shared_posts

  enum profile_privacy: { public: 0, private: 1 }, _prefix: :profile

  scope :public_accounts_with_most_followers, lambda {
    where(profile_privacy: :public)
      .joins(:followers)
      .group('accounts.id')
      .order('COUNT(accounts.id) DESC')
      .limit(10)
  }

  def visible_posts(current_account)
    if profile_public?
      posts
    elsif profile_private?
      if current_account && (current_account == self || current_account.followers?(self))
        posts
      else
        []
      end
    end
  end

  def name_initials
    name.split.map { |word| word[0].capitalize }.join
  end

  protected

  def password_required?
    confirmed? ? super : false
  end
end
