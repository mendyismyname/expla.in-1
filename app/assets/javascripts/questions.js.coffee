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
    debugger

    updateQueryList = ( query )->
      _listItem = _.template( '<li><%= item %></li>' )
      if( questionMemo[ query ].count > 0 )

        $queries
          .slideDown( "fast" )

        $queries
          .append( _listItem( item: questionMemo[ query ].count ) )

        _.each( questionMemo[ query ].questions, ( question )->
          $queries
            .append( _listItem( item: question.content ) )
        )

    $( '#new_question #question_content' )
      .on( 'keyup', ( e )->

        e.stopPropagation()
        $queries.html( '' )
        autofillbar.fill('')

        query = $( this ).val( )

        return unless query

        aSimilarFailure = _.any( _.keys( questionMemo ), ( pastQuery )->
          regExp = new RegExp "^#{ _escapeRegexp( pastQuery ) }", 'i'
          regExp.test( query ) and questionMemo[ pastQuery ].count < 1
        )
        
        if( not aSimilarFailure )

          if( questionMemo[ query ] )

            updateQueryList( query )

          else if( _.any( memoResults = _searchMemo( query ) ) )

            questionMemo[ query ] = 
              count: memoResults.length
              questions: memoResults

            updateQueryList( query )

          else

            $.getJSON( '/questions', { query: query }, ( response )->

              results = 

                questions: response

              questionMemo[ query ] = results
              updateQueryList( query )
            )
        
          if( $queries.html() != '' )
            regExp = new RegExp( "^#{ _escapeRegexp( query ) }", 'i' )
            if( regExp.test( firstQuestion = _.first( questionMemo[ query ].questions ).content )  )
              autofillbar.fill( firstQuestion )
      )
  )

      

