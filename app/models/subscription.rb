class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :question, counter_cache: :total_subscribers
end
