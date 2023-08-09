class AccountsController < ApplicationController
    before_action :authenticate_account!
    
    def index
        # user dashboard(posts)
        
        if !account_signed_in?
            redirect_to new_account_session_path
        end   
        # @posts = Accounts.posts.all

        # @top_public_accounts = Account.public_accounts_with_most_followers
        # @posts = Post.where(account_id: @top_public_accounts)

        if current_account.nil? || current_account.followees.empty?
            @suggested_posts = Account.public_accounts_with_most_followers.includes(:posts).map(&:posts).flatten
        else
            @following_posts = current_account.followees.map(&:visible_posts).flatten
        end

    end   
    
    def show
        # user profile
        @account = Account.find(params[:id])
        @posts = @account.visible_posts(current_account)
    end 

  
end
