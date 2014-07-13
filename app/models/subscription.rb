class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :question, counter_cache: :total_subscribers
  validates :user_id, :uniqueness => { :scope => :question_id }

end
