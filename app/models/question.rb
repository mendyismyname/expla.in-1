class Question < ActiveRecord::Base
  before_save :questionize
  after_save :subscribe

  belongs_to :user
  
  has_many :answers
  has_many :subscriptions, dependent: :destroy

  scope :answered, ->{ 
    where('total_answers > 0')
  }

  scope :unanswered, ->{
    where('total_answers = 0')
  }

  scope :popular, lambda{ |limit = 15|
    order(:total_answers => :desc).limit(limit)
  }

  validates :content, presence: true, uniqueness: { case_sensitive: false }
  validates :user_id, presence: true

  def answered?
    self.total_answers > 0
  end

  def to_s
    content
  end

  private
    def questionize
      self.content = "#{self.content.strip.sub(/\?*$/, '')}?"
    end

    def subscribe
      user.subscribe_to(self)
    end
end
