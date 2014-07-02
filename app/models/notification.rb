class Notification < ActiveRecord::Base
  belongs_to :notifiable, :polymorphic => true

  belongs_to :sender, class: User
  belongs_to :reciever, class: User

end
