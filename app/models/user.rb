class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :name, presence: true
  validates :name, length: { maximum: 100 }
  validates :bio, presence: true
  validates :bio, length: { maximum: 350 }

  def most_recent_posts
    posts.order('created_at DESC').limit(3)
  end
end
