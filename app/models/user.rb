class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :private
  has_many :shouts

  has_many :relationships, foreign_key: "follower_id"
  has_many :following, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
           class_name: "Relationship"
  has_many :followers, through: :reverse_relationships, source: :follower

  validates :username, presence: true
  validates :password, presence: true
  validates :email, presence: true


       # Alternately
     def follows?(other_user)
       self.relationships.find_by(followed_id: other_user.id)
     end

     def follow!(other_user)
       self.relationships.create!(followed_id: other_user.id)
     end

     def unfollow!(other_user)
       self.relationships.find_by(followed_id: other_user.id).destroy
     end

end
