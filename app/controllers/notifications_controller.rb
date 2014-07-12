class NotificationsController < FayeRails::Controller

  observe Notification, :after_create do |new_notification|

    channel = "/notifications/#{new_notification.reciever_id}/#{new_notification.notifiable_id}"

    data = {
      notification: new_notification.attributes
    }
    
    NotificationsController.publish(channel, data)

  end
  
end