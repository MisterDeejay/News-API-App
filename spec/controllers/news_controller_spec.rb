require 'rails_helper'

describe NewsController, type: :controller do
  describe "GET index" do
    let(:json) { JSON.parse(response.body) }
    let!(:articles) { create_list(:news, 20) }

    context 'without language filter' do
      before { get :index }

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end

      it "returns a json object of all news article" do
        expect(response.content_type).to eq("application/json")
        expect(json.count).to eq(20)

        article = json.first
        expect(article['id']).to eq(News.last.id)
        expect(article['title']).to eq(News.last.title)
        expect(article['body']).to eq(News.last.body)
      end

      it 'returns the article ordered from most recent to oldest' do
        more_recent_article_created_at = json.first['created_at']
        (1...json.count).each do |i|
          expect(json[i]['created_at'] <= more_recent_article_created_at).to be_truthy
          more_recent_article_created_at = json[i]['created_at']
        end
      end
    end

    context "filtering by language" do
      let!(:german_article) { FactoryBot.create(:news, language: "German") }
      before { get :index, params: { language: 'German' } }

      it "only return the articles that match that language" do
        expect(News.count).to eq(21)
        expect(json.count).to eq(1)
        expect(json.first['language']).to eq('German')
      end
    end
  end

  describe "POST create" do
    context "with an authorized user" do
      let(:user) { FactoryBot.create(:user) }
      let(:news_params) { { title: "new title", body: "new body" } }

      it "allows for new article creation" do
        auth_token = AuthenticateUser.call(user.email, "123123").result
        @request.headers['Authorization'] = auth_token
        post :create, params: news_params

        article = News.first
        expect(response).to have_http_status(201)
        expect(article.title).to eq(news_params[:title])
        expect(article.body).to eq(news_params[:body])
      end
    end

    context "without an authorized user" do
      it "does not allow for article creation" do
        post :create, params: { title: "new title", body: "new body" }
        expect(response.status).to eq(401)

        error = JSON.parse(response.body)
        expect(error['error']).to eq('Not Authorized')
        expect(News.all.empty?).to be_truthy
      end
    end
  end
end
