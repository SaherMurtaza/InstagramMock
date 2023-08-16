class LikesController < ApplicationController
  before_action :authenticate_account!
  def create
    # @post = Post.find(params[:post_id])
    # @like = @post.likes.build(account: current_account)
    @post = Post.find(params[:post_id])
    @account = @post.account
    @like = @post.likes.build(account: @account)

    if @like.save
      redirect_back fallback_location: @post, notice: 'Post liked!'
    else
      redirect_back fallback_location: @post, alert: 'Error while liking post.'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(account: current_account)

    if @like
      @like.destroy
      redirect_back fallback_location: @post, notice: 'Post unliked.'
    else
      redirect_back fallback_location: @post, alert: 'Error while unliking post.'
    end
  end
end
