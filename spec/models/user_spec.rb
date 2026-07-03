require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    context "username が空である場合" do
      it "無効である" do
        user = build(:user, username: nil)
        user.valid?
        expect(user.errors[:username]).to include("を入力してください")
      end
    end
    context "email が空である場合" do
      it "無効である" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end
    end
    context "password が空である場合" do
      it "無効である" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end
    end
    context "email が重複している場合" do
      it "無効である" do
        create(:user)
        user2 = build(:user, username: "user02", email: "test01@example.com")
        expect(user2).not_to be_valid
      end
    end
    context "username が重複している場合" do
      it "無効である" do
        create(:user)
        user2 = build(:user, username: "user01", email: "test02@example.com")
        expect(user2).not_to be_valid
      end
    end
  end
end


# describe "バリデーション" do       # 何のテスト
#   context "〇〇がない場合" do    # どんな条件
#     it "無効である" do            # 何を期待するか
#     end
#   end
# end