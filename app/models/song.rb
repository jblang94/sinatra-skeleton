class Song < ActiveRecord::Base

  belongs_to :user
  has_many :upvotes

  validates :title, presence: true
  validates :author, presence: true

  def self.order_by_upvote_count
    Song.select("*, COUNT(upvotes.song_id)").joins("LEFT JOIN upvotes ON songs.id = upvotes.song_id").group("songs.id").order("COUNT(upvotes.song_id) DESC")
  end

  def upvote_count
    self.upvotes.count
  end
  
end