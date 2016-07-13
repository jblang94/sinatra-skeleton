class Song < ActiveRecord::Base

  belongs_to :user
  has_many :upvotes

  validates :title, presence: true
  validates :author, presence: true

  def self.order_by_upvote_count
    Song.includes(:upvotes).group("song_id").order("COUNT(upvotes.id) DESC").references(:upvotes)
  end

  def upvote_count
    self.upvotes.count
  end
  
end