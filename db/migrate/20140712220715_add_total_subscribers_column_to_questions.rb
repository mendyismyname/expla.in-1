class AddTotalSubscribersColumnToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :total_subscribers, :integer, default: 0
  end
end
