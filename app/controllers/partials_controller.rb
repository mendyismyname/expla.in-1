class PartialsController < ApplicationController


  def notification
    @notification = Notification.find( params[:notification_id] )

    render_notification( @notification )
  end

  private
    include NotificationsHelper
end
