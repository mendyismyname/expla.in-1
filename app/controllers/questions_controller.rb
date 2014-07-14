class QuestionsController < ApplicationController
  before_action :set_question

  authorize :user

  def index
    respond_to do |format|
      format.html { @questions = Question.popular }
      format.json { @questions = Question.where('content LIKE ?', "%#{params[:query]}%").popular }
    end
  end

  def show
    @answer = Answer.new
    if notification_id = params[ :notification_id ]
      @notification = Notification.find( notification_id )
      @notification.viewed = true
      @notification.save
    end
  end

  def create
    similar_question = Question.where("lower(content) = ?", @question.content.downcase ).first
    if similar_question
      current_user.subscribe_to( similar_question )
      redirect_to question_path( similar_question )
    elsif @question.save
      redirect_to question_path(@question)
    else
      redirect_to user_path(@question.user), notice: "Something went wrong..."
    end
  end
    
  def new
    respond_to do |format|
      format.html { @questions = Question.all }
    end
  end

  def answered
    respond_to do |format|
      format.html { @questions = Question.answered }
    end
  end

  private

    def set_question
      @question = if params[:id]
                    Question.find_by_id(params[:id])
                  else
                    current_user.questions.new
                  end

      if params[:question]
        @question.assign_attributes(question_params)
      end
    end

    def question_params
      params.require(:question).permit(:content)
    end


end
