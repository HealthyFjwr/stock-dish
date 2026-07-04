require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/new" do
    it "200 OKを返すこと" do
      get new_user_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /users" do
    it "登録成功時、dashboardへredirect" do
      post users_path, params: { user: attributes_for(:user) }
      expect(response).to redirect_to(dashboard_path)
      expect(response).to have_http_status(302)
    end
    it "登録失敗時、newへrender" do
      post users_path, params: { user: attributes_for(:user, :invalid_email) }
      expect(response).to have_http_status(422)
    end
  end
end
