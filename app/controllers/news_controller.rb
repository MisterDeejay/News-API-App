class NewsController < ApplicationController
  before_action :authenticate_request, only: [ :create ]

  def index
    render json: News.order('created_at DESC')
  end

  def create
    news_creator = NewsCreator.new(params.permit(:title, :body))
    if news_creator.run
      render json: news_creator.record
    else
      render json: { error: news_creator.errors }, status: :unprocessable_entity
    end
  end
end
