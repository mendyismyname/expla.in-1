class SubscriptionsController < ApplicationController
  authorize :user
  protect_from_forgery except: [:client, :client_subscriptions]

  before_action :set_subscription

  def create
    respond_to do |format|
      if @subscription.save
        format.js
        format.html { redirect_to question_path(@subscription.question) }
      else
        format.js { j(render 'shared/fail') }
        format.html
      end
    end
  end

  def destroy
    @subscription.destroy
    respond_to do |format|
      format.js { render :create }
      format.html { redirect_to question_path(@subscription.question) }
    end
  end

  def index
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.json { render json: Hash[@user.subscriptions.joins(:question).pluck(:question_id, :content)] }
    end
  end

  def client
    respond_to do |format|
      format.js
    end
  end

  def client_subscriptions
    respond_to do |format|
      format.js
    end
  end

  private
    def set_subscription
      @subscription = if id = params[:id]
                        current_user.subscriptions.find(id)
                      else
                        current_user.subscriptions.build(question_id: params[:question_id])
                      end
    end
end
