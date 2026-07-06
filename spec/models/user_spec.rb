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
    context "email が不正な形式である場合" do
      it "無効である" do
        invalid_emails = %w[
          test01example.com
          test01@
          @example.com
          test01@example
          test01@example..com
        ]
        invalid_emails.each do |invalid_email|
          user = build(:user, :invalid_email, email: invalid_email)
          user.valid?
          expect(user.errors[:email]).to include("は不正な値です"), "#{invalid_email} が有効と判定されました"
        end
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
        user1 = create(:user)
        user2 = build(:user, username: "user02", email: user1.email)
        expect(user2).not_to be_valid
      end
    end
    context "email に大文字が含まれる場合" do
      it "小文字に変換されて保存される" do
        user = create(:user, email: "TEST01@EXAMPLE.COM")
        expect(user.email).to eq("test01@example.com")
      end
    end
    context "email が大文字小文字違いで重複している場合" do
      it "無効である" do
        create(:user, email: "test01@example.com")
        user2 = build(:user, username: "user02", email: "TEST01@EXAMPLE.COM")
        expect(user2).not_to be_valid
      end
    end
    context "username が重複している場合" do
      it "無効である" do
        user1 = create(:user)
        user2 = build(:user, username: user1.username, email: "test02@example.com")
        expect(user2).not_to be_valid
      end
    end
    context "usernameが20文字の場合" do
      it "有効であること" do
        user = build(:user, username: "a" * 20)
        expect(user).to be_valid
      end
    end
    context "usernameが21文字の場合" do
      it "無効であること" do
        user = build(:user, username: "a" * 21)
        expect(user).to be_invalid
      end

      it "エラーメッセージが含まれること" do
        user = build(:user, username: "a" * 21)
        user.valid?
        expect(user.errors[:username]).to be_present
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