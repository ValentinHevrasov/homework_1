class User < ActiveRecord::Base
  has_many :petitions
  has_many :votes
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :surname, presence: true
  validates :password_digest, presence: true
  has_secure_password

  def petition_name
    "#{name} #{surname}"
  end
end