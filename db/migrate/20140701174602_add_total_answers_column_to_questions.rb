class AddTotalAnswersColumnToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :total_answers, :integer, default: 0
  end
end
