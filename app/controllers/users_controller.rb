class UsersController < ApplicationController
  
  def index
    @user = current_user
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = current_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
    redirect_to post_images_path
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "更新しました"
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def correct_user
    @user = User.find(params[:id])
    @users = @user
    redirect_to user_path(current_user.id) unless @user == current_user
  end
end