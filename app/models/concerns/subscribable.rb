module Subscribable
  extend ActiveSupport::Concern

  included do
    has_many :subscriptions
    has_many :pending_questions, :through => :subscriptions, :source => :question_id
  end

  def subscribe_to question
    self.subscriptions << question.subscriptions.build
  end

  def subscribed? question
    self.subscriptions.where(question: question).any?
  end
end