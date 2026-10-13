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

  def seasoning_expiry_label(seasoning)
    min_days = seasoning.min_expiry_days
    max_days = seasoning.max_expiry_days
    return if min_days.nil? || max_days.nil?

    days = min_days == max_days ? min_days : "#{min_days}〜#{max_days}"
    "開封後 #{days}日"
  end
end
