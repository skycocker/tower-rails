# frozen_string_literal: true

class PushNotification
  attr_reader :users, :title, :content

  def initialize(user_ids:, title:, content:)
    @user_ids = user_ids
    @title    = title
    @content  = content
  end

  def send
    fcm.send(User.find(user_ids).pluck(:fcm_token), {
      aps: {
        alert: {
          title: title,
          body:  content,
        },
      },
    })
  end

  private

  def fcm
    @fcm = FCM.new(ENV['fcm_server_key'])
  end
end
