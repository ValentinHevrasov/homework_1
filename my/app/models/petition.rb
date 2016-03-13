class Petition < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :text, presence: true, uniqueness: true
end
