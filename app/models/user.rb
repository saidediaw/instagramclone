class User < ApplicationRecord
    mount_uploader :image, ImageUploader
    validates :name,  presence: true, length: { maximum: 30 }
    validates :email, uniqueness: true, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
    before_validation { email.downcase! }
    validates :image, presence: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    has_many :posts
    has_many :favorites, dependent: :destroy

end
