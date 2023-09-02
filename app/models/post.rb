class Post < ApplicationRecord
  has_many :comments, foreign_key: :post_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  after_create :update_user_posts_counter
  after_destroy :update_user_posts_counter

  # Updates the posts counter for a user when it is created

  def update_user_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  # Returns the 5 most recent comments for a post
  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
