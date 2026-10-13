require "rails_helper"

RSpec.describe Seasoning, type: :model do
  describe "validations" do
    let(:seasoning) do
      Seasoning.new(
        name: "醤油",
        category: 0,
        min_expiry_days: 30,
        max_expiry_days: 365
      )
    end

    it "すべての値が正しければ有効であること" do
      expect(seasoning).to be_valid
    end

    it "nameがなければ無効であること" do
      seasoning.name = nil

      expect(seasoning).not_to be_valid
    end

    it "nameが重複していれば無効であること" do
      seasoning.save!
      duplicate = seasoning.dup

      expect(duplicate).not_to be_valid
    end

    it "categoryがなければ無効であること" do
      seasoning.category = nil

      expect(seasoning).not_to be_valid
    end

    context "期限の範囲を設定しない場合" do
      it "minとmaxが両方nilなら有効であること" do
        seasoning.min_expiry_days = nil
        seasoning.max_expiry_days = nil

        expect(seasoning).to be_valid
      end
    end

    context "期限の範囲を設定する場合" do
      it "minとmaxが両方あれば有効であること" do
        expect(seasoning).to be_valid
      end

      it "minだけ設定されていれば無効であること" do
        seasoning.max_expiry_days = nil

        expect(seasoning).not_to be_valid
      end

      it "maxだけ設定されていれば無効であること" do
        seasoning.min_expiry_days = nil

        expect(seasoning).not_to be_valid
      end

      it "minがmaxより大きければ無効であること" do
        seasoning.min_expiry_days = 365
        seasoning.max_expiry_days = 30

        expect(seasoning).not_to be_valid
      end

      it "minが負数なら無効であること" do
        seasoning.min_expiry_days = -1

        expect(seasoning).not_to be_valid
      end

      it "maxが負数なら無効であること" do
        seasoning.max_expiry_days = -1

        expect(seasoning).not_to be_valid
      end
    end
  end
end