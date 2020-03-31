class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @topics = @user.topics.includes([:categories, :topic_categories]).page(params[:page]).per(MAX_OF_DISPLAY)
    @categories = Category.all
  end
end
