class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :image, presence: true
  validates :content, presence: true, length: {in: 1..140}
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

end
