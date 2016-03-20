class Petition < ActiveRecord::Base
  belongs_to :user
  has_many :votes
  validates :title, presence: true
  validates :text, presence: true, uniqueness: true
  # DAY = 30.day
  DAY = 1.minute

  def can_vote_on?(user)
    votes.where(user_id: user.id).any?
  end

  def expired_petition?(petition)
    if Time.now.to_i - DAY > petition.created_at.to_i
      petition.update(expired: 'true')
    end
  end
end
