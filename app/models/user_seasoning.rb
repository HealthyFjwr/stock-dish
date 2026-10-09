class UserSeasoning < ApplicationRecord
  belongs_to  :user
  belongs_to  :seasoning

  validates :seasoning_id, uniqueness: { scope: :user_id }
end
