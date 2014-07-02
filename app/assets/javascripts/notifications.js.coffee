$( document )
  .on( 'page:change', ( )->
    $( document )
      .on( 'notification', ( e, notification )->
        
        $notifications = $( '#notification-list' )
        $notifications.append( notification.partial)
      )
  )