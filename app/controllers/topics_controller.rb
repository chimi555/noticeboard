class TopicsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

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

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(topic_params)
      flash[:success] = "トピックが更新されました！"
      redirect_to topic_path(@topic.id)
    else
      render 'topics/edit'
    end
  end

  def destroy
    @topic.destroy
    flash[:success] = 'トピックが削除されました。'
    redirect_to current_user
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :description)
  end

  def correct_user
    @topic = current_user.topics.find_by(id: params[:id])
    redirect_to root_path if @topic.nil?
  end
end
