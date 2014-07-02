class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :notifications, :foreign_key => :reciever_id
  has_many :subscriptions, :dependent => :destroy

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  include Subscribable

  def to_s
    name
  end
end
