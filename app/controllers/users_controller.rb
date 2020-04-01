class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, only: [:index, :user_destroy]

  def show
    @user = User.find(params[:id])
    @topics = @user.topics.includes([:categories, :topic_categories]).page(params[:page]).per(MAX_OF_DISPLAY)
    @categories = Category.all
  end

  def index
    @users = User.all
  end

  def user_destroy
    if current_user.admin?
      @user = User.find(params[:id])
      @user.destroy
      flash[:success] = "ユーザーを削除しました"
      redirect_to users_path
    else
      flash[:danger] = "ユーザーの削除に失敗しました"
      redirect_to root_path
    end
  end
end
