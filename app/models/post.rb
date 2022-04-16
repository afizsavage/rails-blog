class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :title, presence: true
  validates :title, length: { maximum: 100 }
  validates :text, presence: true

  after_save :update_posts_counter

  def most_recent_comments
    comments.order('created_at DESC').limit(5)
  end

  private

  def update_posts_counter
    author.increment!(:posts_counter)
  end
end
