class Post < ApplicationRecord
  has_many :comments, foreign_key: :post_id
  has_many :likes
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  after_create :update_user_posts_counter

  # Updates the posts counter for a user when it is created

  def update_user_posts_counter
    author.increment!(:posts_counter, 1)
  end

  # Returns the 5 most recent comments for a post
  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
