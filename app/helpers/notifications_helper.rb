module NotificationsHelper


  def render_notification notification, locals={}
    defaults = {
      :main => :li,
      :sender => :span,
      :message => :span,
      :notifiable => :span,
      :html => {
        :class => 'notification',
        :data => {
          :resource => 'notification',
          :id => notification.id
        }
      }
    }
    
    render(partial: notification, locals: defaults.deep_merge(locals), layout: false)
  end

  def render_notification_list notifications, locals={}
    defaults = {
      :main => :ul,
      :notification => :li,
      :html => {
        :class => 'list'
      },
      :notifications => notifications
    }
    
    render('notifications/notification_list', defaults.deep_merge(locals))
  end


end