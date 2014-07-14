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

_highlightWord = ( pattern, question )->
  
  regExp = new RegExp( "#{_escapeRegexp( pattern )}", 'i' )
  $content = question.thumb.find('.content a')

  $content.html( question.content.replace( regExp, '<span class="highlight-word">$&</span>' ) )



$( document )
  .on( 'page:change', ( )->
    $queries = $( '#question-queries' )
    $searchBar = $( '#new_question #question_content' )
    autofillbar = new autoFillBar( '#new_question #question_content' )
    questionMemo = { }

    _searchQuestionHashes = ( hashes, pattern )->

      questionsThatMatchPattern = _.select( hashes, ( hash )->
        pattern.test( hash.content )
      )

      _.uniq( questionsThatMatchPattern, ( hash )->
        hash.id
      )

    _searchMemo = ( query )->
      regExp = new RegExp( ".*#{ _escapeRegexp( query ) }.*", 'i' )
      _searchQuestionHashes( _.flatten( _.pluck( _.values( questionMemo ), 'questions' ) ), regExp )

    updateQuestionList = ( query )->
      if( questionMemo[ query ].count > 0 )

        $queries.html( '' )
        
        _.each( questionMemo[ query ].questions, ( question )->
          unless( question.thumb instanceof $ )
            question.thumb = $( question.thumb )

          _highlightWord( query, question )
          $queries
            .append( question.thumb )
        )
        $queries
          .stop( true, true )
          .slideDown( 'fast' )
      else
        $queries
          .stop( true, true )
          .fadeOut( 'fast' )

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
          $queries.slideUp( 'fast' ,()->
            $queries.html( '' )
          )
          return

        if( questionMemo[ query ] )

          updateQuestionList( query )
          updateAutoFill( query )

        else if( questionMemo[ query[ 0 ] ]  )

          if( _.any( memoResults = _searchMemo( query ) ) )

            questionMemo[ query ] = 
              count: memoResults.length
              questions: memoResults

            updateQuestionList( query )
            updateAutoFill( query )
          else 
            $queries
              .stop( true, true)
              .slideUp( 'fast', ()->
                $queries.html( '' )
              )

        else

          $.getJSON( '/questions', { query: query }, ( response )->

            results = 
              count: response.questions.length
              questions: response.questions

            questionMemo[ query ] = results
            updateQuestionList( query )
            updateAutoFill( query )
          )
      )

    $( document ).on( 'click focusin focusout', 'body, #question-queries, #new_question #question_content', ( e )->
      e.stopPropagation()
      $this = $( this )
      
      if( $queries.html() isnt '' and e.type is 'focusin' and $this.is( '#new_question #question_content' ))
        $queries
          .stop( true, true )
          .slideDown( 'fast' )
      else if ( e.type is 'click' and $this.is( 'body' ) )
        $queries
          .stop( true, true)
          .slideUp( 'fast' )
    )

  )

      

