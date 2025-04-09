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
