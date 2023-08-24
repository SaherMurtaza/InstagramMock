class SharedPostsController < ApplicationController
  def create
    original_post = Post.find(params[:post_id])
    shared_post = current_account.shared_posts.build(post: original_post)
    shared_post.save

    redirect_to current_account, notice: 'Post shared.'
  end

  def destroy
    @shared_post = SharedPost.find(params[:id])
    @shared_post.destroy

    respond_to do |format|
      format.html { redirect_to current_account, notice: 'Post was successfully removed.' }
      format.json { head :no_content }
    end
  end
end
