require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /user/new" do
    it "200 OKを返すこと" do
      get new_user_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /user/edit" do
    let(:user) { create(:user) }

    before do
      post login_path, params: { email: user.email, password: user.password }
    end

    it "200 OKを返すこと" do
      get edit_user_path
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /user/update" do
    let(:user) { create(:user) }

    before do
      post login_path, params: { email: user.email, password: user.password }
    end

    context "編集成功時" do
      before do
        patch user_path, params: {user: { username: "user11" }}
      end

      it "dashboardへredirectすること" do
        expect(response).to redirect_to(dashboard_path)
      end
      it "302 Foundを返すこと" do
        expect(response).to have_http_status(302)
      end
      it "username が変更されていること" do
        user.reload
        expect(user.username).to eq("user11")
      end
    end

    context "usernameが21文字以上の場合" do
      before do
        patch user_path, params: { user: { username: "user111111111111111111" } }
      end

      it "更新に失敗すること" do
        expect(response).to have_http_status(422)
      end
    end

    context "usernameが他ユーザーと重複している場合" do
      let!(:other_user) { create(:user, username: "duplicated_name") }

      before do
        patch user_path, params: { user: { username: "duplicated_name" } }
      end

      it "更新に失敗すること" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "POST /user" do
    it "登録成功時、dashboardへredirect" do
      post user_path, params: { user: attributes_for(:user) }
      expect(response).to redirect_to(dashboard_path)
      expect(response).to have_http_status(302)
    end
    it "登録失敗時、newへrender" do
      post user_path, params: { user: attributes_for(:user, :invalid_email) }
      expect(response).to have_http_status(422)
    end
  end
end
