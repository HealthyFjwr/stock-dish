require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SasoningssHelper. For example:
#
# describe SasoningssHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SeasoningsHelper, type: :helper do
  describe "#seasoning_expiry_label" do
    it "最小値と最大値が異なる場合は範囲で返すこと" do
      seasoning = build(:seasoning, min_expiry_days: 30, max_expiry_days: 60)
      expect(helper.seasoning_expiry_label(seasoning)).to eq("開封後 30〜60日")
    end

    it "最小値と最大値が同じ場合は1つの値で返すこと" do
      seasoning = build(:seasoning, min_expiry_days: 180, max_expiry_days: 180)
      expect(helper.seasoning_expiry_label(seasoning)).to eq("開封後 180日")
    end

    it "未設定の場合はnilを返すこと" do
      seasoning = build(:seasoning, min_expiry_days: nil, max_expiry_days: nil)
      expect(helper.seasoning_expiry_label(seasoning)).to be_nil
    end
  end
end
