class StaticPagesController < ApplicationController

  def home
    @topics = Topic.all.page(params[:page]).per(MAX_OF_DISPLAY_RECENT_TOPICS)
  end
end
