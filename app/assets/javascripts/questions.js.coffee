

$( document )
  .on( 'page:change', ( )->
    $queries = $( '#question-queries' )
    questionMemo = { }

    updateQueryList = ( query )->
      _listItem = _.template( '<li><%= item %></li>' )
      if( questionMemo[ query ].count > 0 )
        $queries
          .append( _listItem( item: questionMemo[ query ].count ) )

        _.each( questionMemo[ query ].questions, ( question )->
          $queries
            .append( _listItem( item: question.content ) )
        )

    $( '#new_question #question_content' )
      .on( 'keyup', ( e )->
        e.stopPropagation( )
        $queries.html( '' )
        query = $( this ).val( )

        aSimilarFailure = _.any( _.keys( questionMemo ), ( q )->
          regExp = new RegExp "^#{ q }"

          regExp.test( query ) && questionMemo[ q ].count < 1
        )

        if query and not aSimilarFailure
          if questionMemo[ query ]
            updateQueryList( query )
          else
            $.getJSON( '/questions', { query: query }, ( response )->

              results = 
                count: response.length
                questions: response

              questionMemo[ query ] = results
              updateQueryList( query )
            )
      )
  )

      

