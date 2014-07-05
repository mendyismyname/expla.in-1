class Notification < ActiveRecord::Base
  belongs_to :notifiable, :polymorphic => true

  belongs_to :sender, class: User
  belongs_to :reciever, class: User

  scope :recent, lambda{ |limit = 15|
    order( :created_at => :desc ).limit( limit )
  }

end
