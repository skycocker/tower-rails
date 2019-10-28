class UserDevice < ApplicationRecord
  belongs_to :user

  validates :user,      presence: true
  validates :fcm_token, presence: true, uniqueness: { scope: :user }
end
