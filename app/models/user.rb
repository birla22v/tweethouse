class User < ActiveRecord::Base
  has_many :shouts
  validates :username, presence: true
  validates :password, presence: true
  validates :email, presence: true
end
