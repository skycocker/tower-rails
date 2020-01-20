# frozen_string_literal: true

class PushNotification
  attr_reader :user_ids, :title, :content, :data

  def initialize(user_ids:, title:, content:, data: {})
    @user_ids = user_ids
    @title    = title
    @content  = content
    @data     = data
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
        title: title,
        body:  content,
        sound: 'default',
        data:  data,
      },
    })
  end

  private

  def fcm
    @fcm = FCM.new(ENV['FCM_SERVER_KEY'])
  end
end
