require 'rails_helper'

describe AuthenticationController, type: :controller do
  context "with a valid user" do
    let(:params) { { email: "hi@hi.com", password: "123123" } }

    it "returns an auth_token to use for authentication" do
      User.create!(params)
      post :authenticate, params: params

      auth_token = JSON.parse(response.body)["auth_token"]
      command = AuthenticateUser.call(params[:email], params[:password])
      expect(auth_token).to eq(command.result)
    end
  end

  context "without a valid user" do
    it "returns an user_authentication error" do
      post :authenticate, params: {}

      error = JSON.parse(response.body)
      expect(error["error"]["user_authentication"][0]).to eq("invalid credentials")
    end
  end
end
