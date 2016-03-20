class Petition < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  validates :title, presence: true
  validates :text, presence: true, uniqueness: true
  DAY = 30

  def can_vote_on?(user)
    votes.where(user_id: user.id).any?
  end

  def expired?(petition)
    
  end
end
