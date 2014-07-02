module AnswersHelper

  def render_answer answer, locals={}
    defaults = {
      :main => :li,
      :q => :h2,
      :a => :p,
      :user => :h4,
      :html => {
        class: 'answer',
        data: {
          resource: 'answer',
          id: answer.id
        }
      }
    }
    render(answer, defaults.deep_merge(locals))
  end
end
