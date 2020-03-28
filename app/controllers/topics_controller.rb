class TopicsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.build(topic_params)
    if @topic.save
      flash[:success] = '新しいトピックが登録されました!'
      redirect_to topic_path(@topic.id)
    else
      flash[:danger] = '新しいトピックの登録に失敗しました。'
      render 'new'
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end
