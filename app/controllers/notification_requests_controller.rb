class NotificationRequestsController < ApiController
  before_action :authenticate_user!

  api :POST, '/notification_requests/tasks', 'Requests a remote notification about tasks that are scheduled near provided location'
  param :latitude,  String
  param :longitude, String
  def tasks
    parsed_latitude  = BigDecimal(params[:latitude])
    parsed_longitude = BigDecimal(params[:longitude])

    return head(422) if parsed_latitude.blank?
    return head(422) if parsed_longitude.blank?

    TaskLocalizationReminderWorker.perform_async(
      current_user.id,
      parsed_latitude,
      parsed_longitude,
    )

    head(204)
  end
end
