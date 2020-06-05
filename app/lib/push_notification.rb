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
    UserDevice.where(user_id: user_ids).pluck(:fcm_token).each do |token|
      notification = Apnotic::Notification.new(token)

      notification.alert = {
        title: title,
        body:  content,
      }

      notification.sound             = 'default'
      notification.custom_payload    = data
      notification.content_available = true
      notification.badge             = 1
      notification.priority          = 10

      push = apnotic.prepare_push(notification)

      push.on(:response) do |response|
        unless response.ok?
          raise Errors::FailedToDeliver, "Token: #{token}"
        end
      end

      apnotic.push_async(push)
      apnotic.join
      apnotic.close
    end
  end

  private

  def apnotic
    @apnotic ||= Apnotic::Connection.new(cert_path: Rails.root.join(*%w(config aps.p12)))
  end
end
