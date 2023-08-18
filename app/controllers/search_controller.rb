class SearchController < ApplicationController
  def index
    if params[:query].present?
      @accounts = Account.where("name LIKE ? OR email LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @account = []
    end
  end

  def show_posts
    @account = Account.find(params[:id])
    @posts = @account.posts
  end
end
