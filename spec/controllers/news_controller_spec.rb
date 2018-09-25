require 'spec_helper'

describe NewsController, type: :controller do
  describe "GET index" do
    before do
      News.create!(title: "title", body: "body")
    end

    it "returns a json object of all news article" do
      get :index

      articles = JSON.parse(response.body)
      expect(response.content_type).to eq("application/json")
      expect(articles.count).to eq(News.count)

      article = articles[0]
      expect(article['id']).to eq(News.first.id)
      expect(article['title']).to eq(News.first.title)
      expect(article['body']).to eq(News.first.body)
    end

    context "filtering by language" do
      before do
        News.create!(title: "tt", body: "bo", language: "German")
        News.create!(title: "tft", body: "bodssss", language: "English")
      end

      it "only return the articles that match that language" do
        get :index, params: { language: "English" }

        articles = JSON.parse(response.body)
        articles.each do |article|
          expect(article['language']).to eq('English')
        end
      end
    end
  end

  describe "POST create" do
    context "with an authorized user" do
      before do
        User.create!(email: "hi@hi.com", password: "123123", password_confirmation: "123123")
      end

      it "allows for new article creation" do
        user = User.first
        auth_token = AuthenticateUser.call(user.email, "123123").result
        @request.headers['Authorization'] = auth_token
        params = { title: "new title", body: "new body" }
        post :create, params: params

        article = News.first
        expect(response.status).to eq(201)
        expect(article.title).to eq(params[:title])
        expect(article.body).to eq(params[:body])

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
