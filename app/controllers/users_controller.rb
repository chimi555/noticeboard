class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @topics = @user.topics.page(params[:page]).per(MAX_OF_DISPLAY_RECENT_TOPICS)
  end
end
