class NewsCreator < BaseCreator
  def initialize(article_params)
    super('News', article_params)
  end

  def run
    begin
      @record = News.find_by(title: @params[:title])
      super unless record.present?
      true
    rescue => e
      errors << e
    end
  end

  class Error < StandardError; end
end
