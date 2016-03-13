class Vote < ActiveRecord::Base
  belongs_to :user_id
  belongs_to :petition_id
end
