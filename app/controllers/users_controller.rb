class AccountsController < ApplicationController
    before_action :authenticate_account!
    
    def index
        # user dashboard(posts)
        @posts = Post
    end   
    
    def show
        # user profile
    end 

  
end