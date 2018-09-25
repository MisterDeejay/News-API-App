class NewsController < ApplicationController
  before_action :authenticate_request, only: [ :create ]

  def index
    @articles = News.order('created_at DESC')
    @articles = @articles.filter_by_language(params['language']) if params['language']
    render json: @articles
  end

  def create
    @article = News.create!(news_params)
    render json: @article, status: :created
  end

  private

  def news_params
    params.permit(:title, :body, :language)
  end
end
