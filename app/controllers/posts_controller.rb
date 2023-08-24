class PostsController < ApplicationController
  def index
    @posts = current_account.posts.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    # debugger
    @post = Post.new(post_params.merge(account_id: current_account.id))
      respond_to do |format|
        if @post.save
          format.js
          format.html { redirect_to posts_url, notice: 'Post created.' }
        else
          alert("problem")
        end
      end

  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      respond_to :js
    else
      flash.now[:error] = 'Something went wrong while updating the post.'
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_archive
    @post = Post.find(params[:id])
    @post.toggle!(:archived)

    redirect_to account_path(current_account)
  end

  def archived
    @archived_posts = current_account.posts.where(archived: true)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.permit(:active, :caption, :location, images: [])
  end

  def find_post
    @post = Post.find_by id: params[:id]

    return if @post
      flash[:danger] = 'Post does not exist!'
      redirect_to root_path
    end
  end
