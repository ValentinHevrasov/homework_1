class Petition < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  validates :title, presence: true
  validates :text, presence: true, uniqueness: true
  DAYS = 30.day
  # DAYS = 2.minute

  def can_vote_on?(user)
    votes.where(user_id: user.id).any?
  end

  def expired_petition?(petition)
    Time.now.to_i - DAYS > petition.created_at.to_i
  end

end
