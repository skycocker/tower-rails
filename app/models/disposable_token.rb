# frozen_string_literal: true

class DisposableToken < ApplicationRecord
  before_validation :generate_value
  before_validation :set_expiry_date

  validates :value,      presence: true
  validates :expires_at, presence: true

  scope :valid, -> { where('expires_at > ?', DateTime.current) }

  def invalidate!
    update!(expires_at: 1.minute.ago)
  end

  def self.use!(value:, user:)
    disposable_token = valid.find_by!(value: value)
    auth_token_data  = user.create_token

    user.save!

    ActionCable.server.broadcast(
      "#{AuthChannel::CHANNEL_NAME_PREFIX}_#{disposable_token.value}",
      token_data: auth_token_data.to_h.merge(uid: user.uid),
    )

    disposable_token.destroy!
  end

  private

  def generate_value
    self.value = Devise.friendly_token(64)
  end

  def set_expiry_date
    self.expires_at = 2.minutes.from_now
  end
end
