class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode
  has_many :post_comments, dependent: :destroy
end
