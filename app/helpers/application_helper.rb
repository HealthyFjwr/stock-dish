module ApplicationHelper
  FLASH_STYLES = {
    "notice" => "bg-green-50 border-green-600 text-green-800",
    "alert" => "bg-red-50 border-red-600 text-red-800"
  }.freeze

  DEFAULT_FLASH_STYLE = "bg-gray-50 border-gray-600 text-gray-800"

  def flash_style(type)
    FLASH_STYLES.fetch(type.to_s, DEFAULT_FLASH_STYLE)
  end
end
