require 'rails_helper'

describe News do
  it { should validate_presence_of(:title) }

  describe ".filter_by_language scope" do
    it "return articles in the matching laguage" do
      german_article = News.create(title: "ttt", body: "bbb", language: "German")
      english_article = News.create(title: "tttr", body: "rbbb", language: "English")
      english_articles = News.all.filter_by_language("English")

      expect(english_articles.count).to eq(1)
      expect(english_articles.include?(english_article)).to be_truthy
      expect(english_articles.include?(german_article)).to be_falsey
    end
  end
end
