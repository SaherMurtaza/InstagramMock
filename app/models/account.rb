class Account < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments    
  has_many :followed_accounts, foreign_key: :follower_id, class_name: "Relationship"
  has_many :followees, through: :followed_accounts, dependent: :destroy, source: :follower

  has_many :following_accounts, foreign_key: :followee_id, class_name: "Relationship"
  has_many :followers, through: :following_accounts, dependent: :destroy, source: :followed

  protected
    def password_required?
      confirmed? ? super : false
    end


end
