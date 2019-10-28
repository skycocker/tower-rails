class MigrateUserFcmTokenToUserDevices < ActiveRecord::Migration[5.1]
  def change
    User.find_each do |user|
      next if user.fcm_token.blank?

      user.user_devices.find_or_create_by!(fcm_token: user.fcm_token)
    end

    remove_column :users, :fcm_token
  end
end
