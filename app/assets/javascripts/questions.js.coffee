_escapeRegexp = ( str )->
  escape = 
    [ '?','.','*','&','|','(',')',
    '[', ']', '\\', '^', '$', '+' ]

  str.split('').map( ( char )->
    if( _.include( escape, char ) )
      "\\#{char}"
    else
      char
  ).join('')


$( document )
  .on( 'page:change', ( )->
    $queries = $( '#question-queries' )
    $searchBar = $( '#new_question #question_content' )
    autofillbar = new autoFillBar( '#new_question #question_content' )
    questionMemo = { }

    _searchQuestionHashes = ( hashes, pattern )->
      _.uniq ( _.select( hashes, ( hash )->
        pattern.test( hash.content )
      ))

    _searchMemo = ( query )->
      regExp = new RegExp( ".*#{ _escapeRegexp( query ) }.*", 'i' )
      _searchQuestionHashes( _.flatten( _.pluck( _.values( questionMemo ), 'questions' ) ), regExp )

    updateQueryList = ( query )->
      if( questionMemo[ query ].count > 0 )

        $queries.html( '' )
        
        _.each( questionMemo[ query ].questions, ( question )->
          $queries
            .append( question.thumb )
        )
        $queries
          .slideDown()
      else
        $queries
          .fadeOut()

    updateAutoFill = ( query )->
      if( $queries.html() != '' )
        regExp = new RegExp( "^#{ _escapeRegexp( query ) }", 'i' )
        if( regExp.test( firstQuestion = _.first( questionMemo[ query ].questions )?.content )  )
          autofillbar.fill( query + firstQuestion.slice( query.length, firstQuestion.length ) )

    $( '#new_question #question_content' )
      .on( 'keyup', ( e )->
        autofillbar.fill('')

        query = $( this ).val( )

        unless query
          $queries.slideUp(()->
            $queries.html( '' )
          )
          return

        aSimilarFailure = _.any( _.keys( questionMemo ), ( pastQuery )->
          regExp = new RegExp "^#{ _escapeRegexp( pastQuery ) }", 'i'
          regExp.test( query ) and questionMemo[ pastQuery ].count < 1
        )
        
        if( not aSimilarFailure )

          if( questionMemo[ query ] )

            updateQueryList( query )
            updateAutoFill( query )

          else if( _.any( memoResults = _searchMemo( query ) ) )

            questionMemo[ query ] = 
              count: memoResults.length
              questions: memoResults

            updateQueryList( query )
            updateAutoFill( query )

          else

            $.getJSON( '/questions', { query: query }, ( response )->

              results = 
                count: response.length
                questions: response

              questionMemo[ query ] = results
              updateQueryList( query )
              updateAutoFill( query )
            )
      )
    $searchBar.on( 'focusout', ( e )->
      $queries.slideUp()
    )
    $searchBar.on( 'focus', ( e )->
      unless( $queries.html() is '' )
        $queries.slideDown() 
    )
  )

      

