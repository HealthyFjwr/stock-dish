require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#flash_style" do
    it "notice の場合、緑系のクラスを返すこと" do
      expect(helper.flash_style(:notice)).to include("green")
    end

    it "alert の場合、赤系のクラスを返すこと" do
      expect(helper.flash_style(:alert)).to include("red")
    end

    it "notice・alert以外のtypeの場合、グレー系のクラスを返すこと" do
      expect(helper.flash_style(:warning)).to include("gray")
    end

    it "文字列型のtypeでも対応すること" do
      expect(helper.flash_style("notice")).to include("green")
    end
  end
end
