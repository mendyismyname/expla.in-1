<% @question.reload %>

answersSelector = '*[data-owner="question_<%= @question.id %>"]'
questionSelector = '*[data-resource="question"][data-id="<%= @question.id %>"]'


$( answersSelector )
  .append( '<%= j(render_answer(@answer, q:false) ) %>' )

$( '#new_answer #answer_content' )
  .val( '' )


$( questionSelector )
  .find( '.answer-count' )
    .html( '<%= @question.total_answers %>' )

