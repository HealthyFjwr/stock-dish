require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /login" do
    it "200 OKを返すこと" do
      get login_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /login" do
    let!(:user) { create(:user) }

    context "email/passwordが正しい場合" do
      it "dashboardへredirectすること" do
        post login_path, params: { email: user.email, password: user.password }
        expect(response).to redirect_to(dashboard_path)
        expect(response).to have_http_status(302)
      end

      it "session[:user_id]にログインユーザーのidがセットされること" do
        post login_path, params: { email: user.email, password: user.password }
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context "passwordが間違っている場合" do
      it "401を返すこと" do
        post login_path, params: { email: user.email, password: "wrong_password" }
        expect(response).to have_http_status(401)
      end
    end

    context "存在しないemailの場合" do
      it "401を返すこと" do
        post login_path, params: { email: "notfound@example.com", password: "password01" }
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE /logout" do
    let(:user) { create(:user) }

    before do
      post login_path, params: { email: user.email, password: user.password }
    end

    it "root_pathへredirectすること" do
      delete logout_path
      expect(response).to redirect_to(root_path)
    end

    it "session[:user_id]がクリアされること" do
      delete logout_path
      expect(session[:user_id]).to be_nil
    end
  end
end
