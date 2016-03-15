class Vote < ActiveRecord::Base
  belongs_to :user_id
  belongs_to :petition_id
  validates :user_id, uniqueness: {scope: :petition_id}
end
