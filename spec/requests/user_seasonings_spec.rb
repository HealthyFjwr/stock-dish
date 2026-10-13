require 'rails_helper'

RSpec.describe "UserSeasonings", type: :request do
  describe "GET /user_seasonings" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let!(:soy_sauce) { create(:seasoning, name: "醤油", category: :basic, min_expiry_days: 30, max_expiry_days: 60) }
    let!(:sesame_oil) { create(:seasoning, name: "ごま油", category: :oil, min_expiry_days: 180, max_expiry_days: 180) }
    let!(:mayonnaise) { create(:seasoning, name: "マヨネーズ", category: :dressing) }

    context "ログインしている場合" do
      before do
        create(:user_seasoning, user: user, seasoning: soy_sauce)
        create(:user_seasoning, user: user, seasoning: sesame_oil)
        create(:user_seasoning, user: other_user, seasoning: mayonnaise)
        post login_path, params: { email: user.email, password: user.password }
      end

      it "200 OKを返すこと" do
        get user_seasonings_path
        expect(response).to have_http_status(200)
      end

      it "ログインユーザーの所持調味料のみ表示すること" do
        get user_seasonings_path
        expect(response.body).to include("醤油", "ごま油")
        expect(response.body).not_to include("マヨネーズ")
      end

      it "賞味期限の目安を表示すること" do
        get user_seasonings_path
        expect(response.body).to include("開封後 30〜60日", "開封後 180日")
      end

      it "カテゴリで絞り込めること" do
        get user_seasonings_path, params: { category: "oil" }
        expect(response.body).to include("ごま油")
        expect(response.body).not_to include("醤油")
      end

      it "不正なカテゴリは無視してすべて表示すること" do
        get user_seasonings_path, params: { category: "invalid" }
        expect(response.body).to include("醤油", "ごま油")
      end
    end

    context "ログインしていない場合" do
      it "ログインページへリダイレクトすること" do
        get user_seasonings_path
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "POST /user_seasonings" do
    let(:user) { create(:user) }
    let!(:soy_sauce) { create(:seasoning, name: "醤油", category: :basic) }
    let!(:sesame_oil) { create(:seasoning, name: "ごま油", category: :oil) }
    let!(:salt) { create(:seasoning, name: "塩", category: :basic) }

    context "ログインしている場合" do
      before do
        post login_path, params: { email: user.email, password: user.password }
      end

      context "調味料を選択した場合" do
        it "選択した調味料をまとめて登録すること" do
          expect {
            post user_seasonings_path, params: { seasoning_ids: [ soy_sauce.id, sesame_oil.id ] }
          }.to change(user.user_seasonings, :count).by(2)
          expect(user.seasonings).to contain_exactly(soy_sauce, sesame_oil)
        end

        it "所持調味料一覧へリダイレクトすること" do
          post user_seasonings_path, params: { seasoning_ids: [ soy_sauce.id ] }
          expect(response).to redirect_to(user_seasonings_path)
          expect(flash[:notice]).to eq("1件の調味料を登録しました")
        end

        it "登録済みの調味料は重複して登録しないこと" do
          create(:user_seasoning, user: user, seasoning: soy_sauce)
          expect {
            post user_seasonings_path, params: { seasoning_ids: [ soy_sauce.id, salt.id ] }
          }.to change(user.user_seasonings, :count).by(1)
        end

        it "存在しない調味料IDは無視すること" do
          expect {
            post user_seasonings_path, params: { seasoning_ids: [ salt.id, 0 ] }
          }.to change(user.user_seasonings, :count).by(1)
        end
      end

      context "調味料を選択していない場合" do
        it "登録せず調味料追加画面へリダイレクトすること" do
          expect {
            post user_seasonings_path
          }.not_to change(UserSeasoning, :count)
          expect(response).to redirect_to(seasonings_path)
          expect(flash[:alert]).to eq("調味料を選択してください")
        end
      end
    end

    context "ログインしていない場合" do
      it "登録せずログインページへリダイレクトすること" do
        expect {
          post user_seasonings_path, params: { seasoning_ids: [ soy_sauce.id ] }
        }.not_to change(UserSeasoning, :count)
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
