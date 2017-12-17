class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :postcomments, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :voteforphotos, dependent: :destroy


  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/default.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :nickname, :email, :password, :password_confirmation, presence: true
  validates :nickname, length: { in: 6..20 }
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
