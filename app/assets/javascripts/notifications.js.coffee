$( document )
  .on( 'page:change', ( )->
    $notifications = $( '#notification-list' )
    $notificationButton = $('#notifications-button')
    $( document )
      .on( 'notification', ( e, data )->

        $.get( "/partials/notification/#{ data.notification.id }", ( response )->
          $notificationButton.addClass('alert')
          $notifications.prepend( response )
        )
      )

    $( document )
      .on( 'click', 'body, #notifications-button, #notification-list', ( e )->
        e.stopPropagation()
        $this = $( this )
        if( $this.is( '#notifications-button' ) )
          e.preventDefault()
          $notificationButton.removeClass('alert')

          $notifications.fadeIn( 500 )
        else if( $this.is( 'body' ) )
          $notifications.fadeOut()
      )
  )