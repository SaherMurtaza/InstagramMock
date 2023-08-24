class AccountsController < ApplicationController
  before_action :authenticate_account!

  def index
    # user Home
    if !account_signed_in?
        redirect_to new_account_session_path
    end
    if current_account.nil? || current_account.followees.empty?
        @suggested_posts = Account.public_accounts_with_most_followers.includes(:posts).map(&:posts).flatten
    else
        @following_posts = current_account.followees.map{ |followee| followee.visible_posts(@acc) }.flatten
    end
  end

  def show
    # user profile
    @account = Account.find(params[:id])
    @posts = @account.visible_posts(current_account)
    @post = Post.new

    @shared_posts = @account.shared_posts
  end

  def follow
    @account = Account.find(params[:id])
    current_account.followees << @account
    redirect_back(fallback_location: account_path(@account))
  end

  def unfollow
    @account = Account.find(params[:id])
    current_account.followed_accounts.find_by(followee_id: @account.id).destroy
    redirect_back(fallback_location: account_path(@account))
  end

  def admin_dashboard
    @accounts = Account.all
    @posts = Post.all
  end

  def activate
    account = Account.find(params[:id])
    account.update(active: true)
    redirect_to accounts_path, notice: 'Account activated.'
  end

  def deactivate
    account = Account.find(params[:id])
    account.update(active: false)
    redirect_to accounts_path, notice: 'Account deactivated.'
  end
end
