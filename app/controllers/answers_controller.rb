class AnswersController < ApplicationController


  def create
    @question = Question.find_by_id(params[:question_id])
    @answer = current_user.answers.build(answer_params)

    respond_to do |format|
      if @question.answers << @answer
        format.html { redirect question_path(@question), notice: "Good job! you just answered #{@question.user.name}'s question." }
        format.js
      else
        @message = "Could not commit answer."

        format.html { render @question }
        format.js { j(render 'shared/fail') }
      end
    end
  end

  private

    def answer_params
      params.require(:answer).permit(:content)
    end

end
