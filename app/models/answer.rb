class Answer < ActiveRecord::Base
  after_save :notify
  
  belongs_to :user
  belongs_to :question, counter_cache: :total_answers

  validates :content, presence: :true

  private
    def notify
      message = self.content
      sender = self.user
      self.question.subscriptions.each do |subscription|
        unless (reciever = subscription.user) == sender
          Notification.create(
            sender: sender, 
            reciever: reciever, 
            message: message,
            notifiable: self.question
            )
        end
      end
    end
end
