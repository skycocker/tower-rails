class PushNotification
  attr_reader :fcm_server_key, :users, :title, :content

  def initialize(fcm_server_key:, users:, title:, content:)
    @users   = users
    @title   = title
    @content = content
    @fcm_server_key = fcm_server_key
  end

  def send
    fcm.send(users.pluck(:fcm_token), {
      aps: {
        alert: {
          title: title,
          body:  content,
        },
      },
      notification: {
        title: title,
        body:  content,
      },
    })
  end

  private

  def fcm
    @fcm = FCM.new(fcm_server_key)
  end
end
