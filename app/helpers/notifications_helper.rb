module NotificationsHelper


  def render_notification notification, locals={}
    defaults = {
      :main => :div,
      :sender => :h4,
      :message => :p,
      :notifiable => :h6,
      :html => {
        :class => 'notification',
        :data => {
          :resource => 'notification',
          :id => notification.id
        }
      }
    }
    if respond_to? :render
      render(notification, defaults.deep_merge(locals))
    else
      defaults[:notification] = notification
       ActionView::Base.new(Rails.configuration.paths["app/views"]).render(
          :partial => 'notifications/notification', :format => :txt,
          locals: defaults.deep_merge(locals)
        )
    end
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