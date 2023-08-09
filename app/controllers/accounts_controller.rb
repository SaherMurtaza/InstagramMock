class AccountsController < ApplicationController
    before_action :authenticate_account!
    
    def index
        # user dashboard(posts)
        if !account_signed_in?
            redirect_to new_account_session_path
        end    
    end   
    
    def show
        # user profile
        @account = Account.find(params[:id])
    end 

  
end
