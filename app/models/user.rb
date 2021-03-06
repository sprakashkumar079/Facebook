class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  def feed
    Micropost.where("user_id = ?", id)
  end
end
