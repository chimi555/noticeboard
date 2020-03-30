class TopicsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_available_categories, only: [:edit, :new]

  def index
    if params[:category_id]
      @selected_category = Category.find(params[:category_id])
      @topics = Topic.from_category(params[:category_id]).page(params[:page]).per(MAX_OF_DISPLAY)
    elsif params[:q]
      @topics = @search.result.page(params[:page]).per(MAX_OF_DISPLAY)
      @search_word = params[:q][:title_or_description_or_comments_content_cont]
    else
      @topics = Topic.page(params[:page]).per(MAX_OF_DISPLAY)
    end
    @categories = Category.all
  end

  def show
    @topic = Topic.find(params[:id])
    @comment = Comment.new
    @comments = @topic.comments.includes([:user]).page(params[:page]).per(MAX_OF_DISPLAY)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.build(topic_params)
    category_list = params[:category_list].split(",")
    if @topic.save
      @topic.save_categories(category_list)
      flash[:success] = '新しいトピックが登録されました!'
      redirect_to topic_path(@topic.id)
    else
      flash[:danger] = '新しいトピックの登録に失敗しました。'
      render 'new'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
    @category_list = @topic.categories.pluck(:category_name).join(",")
  end

  def update
    @topic = Topic.find(params[:id])
    category_list = params[:category_list].split(",")
    if @topic.update_attributes(topic_params)
      @topic.save_categories(category_list)
      flash[:success] = "トピックが更新されました！"
      redirect_to topic_path(@topic.id)
    else
      render 'topics/edit'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
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

  def set_available_categories
    @all_category_list = Category.all.pluck(:category_name)
  end
end
