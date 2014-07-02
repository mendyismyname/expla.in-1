class NotificationsController < FayeRails::Controller
  extend NotificationsHelper

  observe Notification, :after_create do |new_notification|

    channel = "/notifications/#{new_notification.reciever_id}/#{new_notification.notifiable_id}"
    data = {
      partial: NotificationsController.render_notification(new_notification, main: :li),
      notification: new_notification.attributes
    }
    NotificationsController.publish(channel, data)

  end
  
end