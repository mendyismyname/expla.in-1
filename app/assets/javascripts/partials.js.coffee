# $( '#new_question input#question_content' ).on( 'keyup', ( e )->
#   query = $( this ).val( )

#   $.getJSON( '/questions', { query: query }, ( response )->

#     updateQuestionList( query )
#     updateAutoFill( query )
#   )
# )


# questionMemo = { }

# $( '#new_question #question_content' ).on( 'keyup', ( e )->

#   query = $( this ).val( )

#   if( questionMemo[ query ] )

#     updateQuestionList( query )
#     updateAutoFill( query )

#   else if( questionMemo[ query[ 0 ] ] && _.any( memoResults = _searchMemo( query ) ) )

#       questionMemo[ query ] = memoResults

#       updateQuestionList( query )
#       updateAutoFill( query )

#   else

#     $.getJSON( '/questions', { query: query }, ( response )->

#       questionMemo[ query ] = response.questions

#       updateQuestionList( query )
#       updateAutoFill( query )
#     )
# )