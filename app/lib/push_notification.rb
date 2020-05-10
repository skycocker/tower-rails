# frozen_string_literal: true

class PushNotification
  attr_reader :user_ids, :title, :content, :data, :overrides

  def initialize(user_ids:, title:, content:, data: {}, overrides: {})
    @user_ids  = user_ids
    @title     = title
    @content   = content
    @data      = data
    @overrides = overrides
  end

  def send
    fcm.send(UserDevice.where(user_id: user_ids).pluck(:fcm_token), {
      aps: {
        alert: {
          title: title,
          body:  content,
        },
      },
      notification: {
        title:             title,
        body:              content,
        sound:             'default',
        data:              data,
        priority:          'high',
        content_available: true,
      }.merge(overrides),
    })
  end

  private

  def fcm
    @fcm = FCM.new(Rails.application.config_for(:fcm)['server_key'])
  end
end
