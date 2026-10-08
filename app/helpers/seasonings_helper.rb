module SeasoningsHelper
  SEASONING_CATEGORY_LABELS = {
    "basic" => "基本調味料",
    "fermented" => "発酵系",
    "oil" => "油",
    "sauce" => "ソース系",
    "dressing" => "ドレッシング",
    "stock" => "だし・スープ系",
    "spice" => "香辛料",
    "paste" => "ペースト系",
    "sweetener" => "甘味料",
    "other" => "その他"
  }.freeze

  def seasoning_category_label(category)
    SEASONING_CATEGORY_LABELS.fetch(category.to_s, "その他")
  end
end
