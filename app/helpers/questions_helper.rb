module QuestionsHelper

  def render_question question, locals={}
    default_tags = {
      :html => {
        class: 'question', 
        data: { 
          resource: 'question', 
          id: question.id
        }
      }
    }
    render(question, default_tags.deep_merge(locals))
  end

  def render_question_list list, locals={}
    defaults = {
      :main => :div,
      :list => :ul,
      :question => :li,
      :title => "Questions",
      :html => {
        :class => "questions"
      },
      :questions => list
    }
    render 'questions/question_list', defaults.deep_merge(locals)
  end
end
