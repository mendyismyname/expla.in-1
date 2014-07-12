# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/


# questionMemo = { }

# $( '#new_question #question_content' )
#   .on( 'keyup', ( e )->

#     query = $( this ).val( )

#     aSimilarFailure = _.any( _.keys( questionMemo ), ( pastQuery )->
#       regExp = new RegExp "^#{ _escapeRegexp( pastQuery ) }", 'i'
#       regExp.test( query ) and questionMemo[ pastQuery ].count < 1
#     )
    
#     if( not aSimilarFailure )

#       if( questionMemo[ query ] )

#         updateQueryList( query )

#       else if( _.any( memoResults = _searchMemo( query ) ) )

#         questionMemo[ query ] = 
#           count: memoResults.length
#           questions: memoResults

#         updateQueryList( query )

#       else

#         $.getJSON( '/questions', { query: query }, ( response )->

#           results = 
#             count: response.length
#             questions: response

#           questionMemo[ query ] = results
#           updateQueryList( query )
#         )
#   )