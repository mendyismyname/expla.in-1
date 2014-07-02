class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :reciever_id
      t.integer :sender_id
      t.string :message
      # 
      # notifiable is data that the notification
      # is triggered on 
      # ei. user answers a question, 
      # the question is notifiable

      t.string :notifiable_type
      t.integer :notifiable_id

      t.timestamps
    end
  end
end
