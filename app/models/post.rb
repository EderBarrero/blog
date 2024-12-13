class Post < ApplicationRecord

  belongs_to :user

  validates :title, :body, presence: true

  scope :sorted, -> { order(published_at: :desc, updated_at: :desc)}
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :draft_user, ->(user) { where("published_at: nil and user_id = ?", user.id) }
  scope :published_user, ->(user) { where("published_at <= ? and user_id = ?", Time.current, user.id) }
  scope :scheduled_user, ->(user) { where("published_at > ? and user_id = ?", Time.current, user.id) }
  scope :all_user, ->(user) { where("user_id = ?", user.id) }


  def draft?
    published_at.nil?
  end

  def published? 
    published_at? && published_at <= Time.current 
  end

  def scheduled?
    published_at? && published_at > Time.current
  end
end
