class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to posts_path
    else
      @posts = Post.all
      @user = current_user
      render :index
    end
  end

  def index
    @posts = Post.all
    @user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @posts = Post.all
    @user = @post.user

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "更新しました"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "削除しました"
    @posts = Post.all
    @user = current_user
    render :index

  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :body)
  end
  
  def correct_user
    @post = Post.find(params[:id])
    @user = @post.user
    redirect_to posts_path unless @user == current_user
  end
end
