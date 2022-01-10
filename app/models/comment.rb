class Comment < ApplicationRecord
  attr_accessible :comment_content
  belongs_to :post
  belongs_to :user
  has_many :likes, dependent: :destroy
  validates :comment_content, presence: true
  validates :user_id, presence: true
  validates :micropost_id, presence: true
end
