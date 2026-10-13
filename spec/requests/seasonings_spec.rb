require 'rails_helper'

RSpec.describe "Seasonings", type: :request do
  describe "GET /seasonings" do
    let(:user) { create(:user) }
    let!(:soy_sauce) { create(:seasoning, name: "醤油", category: :basic, min_expiry_days: 30, max_expiry_days: 60) }
    let!(:sesame_oil) { create(:seasoning, name: "ごま油", category: :oil, min_expiry_days: 180, max_expiry_days: 180) }

    context "ログインしている場合" do
      before do
        post login_path, params: { email: user.email, password: user.password }
      end

      it "200 OKを返すこと" do
        get seasonings_path
        expect(response).to have_http_status(200)
      end

      it "賞味期限の目安を表示すること" do
        get seasonings_path
        expect(response.body).to include("開封後 30〜60日", "開封後 180日")
      end

      it "未登録の調味料は選択できること" do
        get seasonings_path
        expect(response.body).to include(%(value="#{sesame_oil.id}"))
      end

      it "登録済みの調味料は選択できず登録済みと表示すること" do
        create(:user_seasoning, user: user, seasoning: soy_sauce)
        get seasonings_path
        expect(response.body).not_to include(%(value="#{soy_sauce.id}"))
        expect(response.body).to include("登録済み")
      end
    end

    context "ログインしていない場合" do
      it "ログインページへリダイレクトすること" do
        get seasonings_path
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
