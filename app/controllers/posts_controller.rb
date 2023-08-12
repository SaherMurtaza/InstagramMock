class PostsController < ApplicationController

  def index
    @posts = current_account.posts.all
  end

  def show
    @post = current_account.posts.find(params[:id])
    # @likes = @posts.likes.includes(:account)
    @is_liked = @post.is_liked(current_account)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params.merge(account_id: current_account.id))

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   respond_to do |format|
  #     if @post.update(post_params)
  #       format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
  #       format.json { render :show, status: :ok, location: @post }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @post.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      respond_to :js
    else
      flash.now[:error] = "Something went wrong while updating the post."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:active, :caption, :location, :images)
    end

    def find_post
      @post = Post.find_by id: params[:id]

      return if @post
      flash[:danger] = "Post not exist!"
      redirect_to root_path
    end
end
