$( document )
  .on( 'page:change', ( )->
    $( document )
      .on( 'notification', ( e, notification )->
        $notifications = $( '#notification-list' )
        $notifications.prepend( notification.partial )
      )
  )