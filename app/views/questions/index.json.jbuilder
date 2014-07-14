json.questions(@questions) do |question|
  json.id question.id
  json.content question.content
  json.thumb render(formats: ['html'], partial: 'questions/thumb', locals: { question: question })
end