# frozen_string_literal: true

class PushNotification
  attr_reader :user_ids, :title, :content, :data, :category

  def initialize(user_ids:, title:, content:, data: {}, category: nil)
    @user_ids  = user_ids
    @title     = title
    @content   = content
    @data      = data
    @category = category
  end

  def send
    UserDevice.where(user_id: user_ids).pluck(:fcm_token).each do |token|
      notification = Apnotic::Notification.new(token)

      notification.alert = {
        title: title,
        body:  content,
      }

      notification.topic             = 'com.vomit.Tower'
      notification.category          = category
      notification.sound             = 'default'
      notification.custom_payload    = { data: data }
      notification.content_available = 1
      notification.priority          = 10

      push = apnotic.prepare_push(notification)

      push.on(:response) do |response|
        unless response.ok?
          if response.body['reason'].present? && response.body['reason'] == 'BadDeviceToken'
            UserDevice.find_by!(fcm_token: token).destroy!
          else
            Rollbar.warning("Failed to deliver APNS notification: #{response.body}")
          end
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
