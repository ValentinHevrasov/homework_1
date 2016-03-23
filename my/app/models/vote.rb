class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :petition
  validates :user_id, uniqueness: {scope: :petition_id}
  # VOTES = 1
  VOTES = 100
end
