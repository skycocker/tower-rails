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

      notification.topic             = 'com.vomit.Tower'
      notification.sound             = 'default'
      notification.custom_payload    = data
      notification.content_available = true

      push = apnotic.prepare_push(notification)

      push.on(:response) do |response|
        unless response.ok?
          if response.body['reason'].present? && response.body['reason'] == 'BadDeviceToken'
            UserDevice.find_by!(fcm_token: token).destroy!
          else
            raise Errors::FailedToDeliver, "Error body: #{response.body}"
          end
        else
          puts 'Delivered an APNS notification successfully'
        end
      end

      apnotic.push_async(push)
      apnotic.join
      apnotic.close
    end
  end

  private

  def apnotic
    @apnotic ||= Apnotic::Connection.development(cert_path: Rails.root.join(*%w(config aps.p12)))
  end
end
