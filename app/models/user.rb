class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
         #:recoverable,
         
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  def favorite(post)
    self.favorites.find_or_create_by(post: post)
  end

  def unfavorite(post)
    self.favorites.find_by(post: post)&.destroy
  end

  def favorite?(post)
    self.favorite_posts.include?(post)
  end

  has_many :followings, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :following_users, through: :followings, source: :followed
  has_many :followers, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :follower_users, through: :followers, source: :follower

  def follow(user)
    self.followings.find_or_create_by(followed: user)
  end

  def unfollow(user)
    self.followings.find_by(followed: user)&.destroy
  end

  def following?(user)
    self.following_users.include?(user)
  end
  
  def self.guest
    user = self.find_or_initialize_by(email: "guest@test.com")
    user.assign_attributes(
    password: SecureRandom.hex(6),
    name: "ゲスト"
    )
    user.save
    user
  end
end
