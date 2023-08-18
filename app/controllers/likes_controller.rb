class LikesController < ApplicationController
  def create
    @like = current_account.likes.new(like_params)
    flash[:alert] = "You already liked this post" unless @like.save
    redirect_to @like.post
  end

  def destroy
    @like = current_account.likes.find(params[:id])
    @like.destroy
    redirect_to @like.post
  end

  def like_params
    params.require(:like).permit(:post_id)
  end
end
