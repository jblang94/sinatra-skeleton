class Song < ActiveRecord::Base

  belongs_to :user
  has_many :upvotes

  validates :title, presence: true
  validates :author, presence: true

  def self.order_by_upvote_count
    Song.select("*, COUNT(upvotes.id)").joins("LEFT JOIN upvotes ON songs.id = upvotes.song_id").group("songs.id").order("COUNT(upvotes.id) DESC")
  end
  
end