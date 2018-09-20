class NewsController < ApplicationController
  before_action :authenticate_request, only: [ :create ]

  def index
    @articles = News.order('created_at DESC')
    @articles = @articles.filter_by_language(language_params['language']) if language_params['language']
    render json: @articles
  end

  def create
    news_creator = NewsCreator.new(news_params)
    if news_creator.run
      render json: news_creator.record
    else
      render json: { error: news_creator.errors }, status: :unprocessable_entity
    end
  end

  private

  def language_params
    params.permit(:language)
  end

  def news_params
    params.permit(:title, :body)
  end
end
