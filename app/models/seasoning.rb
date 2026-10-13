class Seasoning < ApplicationRecord
  # category enum
  enum :category, {
    basic: 0,
    fermented: 1,
    oil: 2,
    sauce: 3,
    dressing: 4,
    stock: 5,
    spice: 6,
    paste: 7,
    sweetener: 8,
    other: 9
  }

  # validations
  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :min_expiry_days, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :max_expiry_days, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # custom validations
  validate :expiry_days_range

  # relation table
  has_many :user_seasonings
  has_many :users, through: :user_seasonings

  private
  def expiry_days_range
    if min_expiry_days.present? && max_expiry_days.present? && min_expiry_days > max_expiry_days
      errors.add(:min_expiry_days, "は最大賞味期限日数より小さい必要があります")
    end

    if min_expiry_days.nil? != max_expiry_days.nil?
      errors.add(:base, "賞味期限の日数は最小値と最大値を両方設定してください")
    end
  end
end
